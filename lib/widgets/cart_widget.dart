import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../utils/utils.dart';

class CartWidget extends StatefulWidget {
  final snap;

  const CartWidget({Key? key, required this.snap}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  bool _isLoading = false;
  int discountPercent = 0;
  var _productData = {};
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadProductDetails();
  }

  void loadProductDetails() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var productSnap = await FirebaseFirestore.instance
          .collection("products")
          .doc(widget.snap['productId'])
          .get();
      if (productSnap.exists) {
        setState(() {
          _productData = productSnap.data()!;
          discountPercent = int.parse(_productData['productCuttedPrice']) -
              int.parse(_productData['productPrice']);
          discountPercent = discountPercent * 100;
          discountPercent =
              discountPercent ~/ int.parse(_productData['productCuttedPrice']);
          _isLoading = false;
        });
      } else {}
    } catch (e) {
      Utils().showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
            strokeWidth: 1,
          ))
        : Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: PhysicalModel(
              color: Colors.white,
              shadowColor: Colors.blue,
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 0, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          _productData['productImage'],
                          width: 100,
                          height: 100,
                        ),
                        Expanded(
                          child: Container(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: Text(
                                    _productData['productTitle'],
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: Text(
                                    _productData['productDescription'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Rs.${_productData['productCuttedPrice']}",
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        "Rs.${_productData['productPrice']}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        discountPercent != null
                                            ? "${discountPercent}% OFF"
                                            : "",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 0, bottom: 0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text(
                            "Delivery within ${_productData['deliveryWithin']}   | ",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          "  Rs.${_productData['deliveryFee']}",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          );
  }
}
