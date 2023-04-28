import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_admin/screens/new_seller_verification_screen.dart';
import '../../animations/fade_animation.dart';
import '../../utils/utils.dart';
import '../all_product_screen.dart';
import '../login_screen.dart';
import '../new_qc_product_screen.dart';
import '../verified_seller.dart';

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({Key? key}) : super(key: key);

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  var _adminData = {};
  bool _isLoading = true;

  int verifiedSellersNo = 0;
  int newSellersVerifyNo = 0;
  int newQCProductNo = 0;
  int verifiedProductNo = 0;

  final CollectionReference sellerRef = FirebaseFirestore.instance
      .collection('sellers');

  final CollectionReference productRef = FirebaseFirestore.instance
      .collection('products');

  void getProductsCount() {
    final Query verifiedSellers =
    sellerRef.where("isVerified", isEqualTo:  true);

    verifiedSellers.get().then((QuerySnapshot snapshot) {
      setState(() {
        verifiedSellersNo = snapshot.size;
      });

    });

    final Query newSellerVerification =
    sellerRef.where("isVerified", isEqualTo:  false);

    newSellerVerification.get().then((QuerySnapshot snapshot) {
      setState(() {
        newSellersVerifyNo = snapshot.size;
      });

    });

    final Query newQC =
    productRef
        .where("isDetailsCompleted", isEqualTo: true)
        .where('active', isEqualTo: false);

    newQC.get().then((QuerySnapshot snapshot) {
      setState(() {
        newQCProductNo = snapshot.size;
      });
    });


    final Query verifiedProducts =
    productRef
        .where("isDetailsCompleted", isEqualTo: true)
        .where('active', isEqualTo: true);

    verifiedProducts.get().then((QuerySnapshot snapshot) {
      setState(() {
        verifiedProductNo = snapshot.size;
      });
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserDetails();
    getProductsCount();
  }

  void loadUserDetails() async {
    try {
      var sellerSnap = await FirebaseFirestore.instance
          .collection("admin")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (sellerSnap.exists) {
        setState(() {
          _adminData = sellerSnap.data()!;
          _isLoading = false;
        });
      } else {}
    } catch (e) {
      Utils().showSnackBar(context, e.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (BuildContext context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 6,
                      ),
                      child: Icon(
                        Icons.shopping_bag,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                    _isLoading ? CircularProgressIndicator(strokeWidth: 2, color: Colors.white,):
                    Text(
                      "${_adminData['name']}",
                      style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 14,
                          color: Colors.white,
                          letterSpacing: 0.5),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {

                },
                child:
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 6,
                        ),
                        child: Icon(
                          Icons.production_quantity_limits,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "New QC",
                        style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 14,
                            color: Colors.white,
                            letterSpacing: 0.5),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: GestureDetector(
                  onTap: () {

                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 6),
                          child: Icon(
                            Icons.shopping_bag_outlined,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "All Products",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white,
                              letterSpacing: 0.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 0,
                ),
              ),
              GestureDetector(
                onTap: () {
                },
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    )),
              )
            ],
          );
        }),
      ),
      body:
          _isLoading ? Center(child: CircularProgressIndicator(strokeWidth: 2,)):
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${_adminData['name']} all Activity",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> VerifiedSellerScreen()));
                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      elevation: 7,
                      shadowColor: Colors.blue.shade100,
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "All Sellers",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                                Text(
                                  " \n( $verifiedSellersNo ) ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> NewSellerVerificationScreen()));
                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      elevation: 7,
                      shadowColor: Colors.blue.shade100,
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Seller Account Verification",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                                Text(
                                  " \n( $newSellersVerifyNo ) ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> NewQCProductScreen()));
                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      elevation: 7,
                      shadowColor: Colors.blue.shade100,
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "New QC",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                                Text(
                                  " \n( $newQCProductNo ) ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      elevation: 7,
                      shadowColor: Colors.blue.shade100,
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Trending Shop",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                                Text(
                                  " \n( 0 ) ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> AllProductScreen()));
                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      elevation: 7,
                      shadowColor: Colors.blue.shade100,
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "All Products",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                                Text(
                                  " \n( $verifiedProductNo ) ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      elevation: 7,
                      shadowColor: Colors.blue.shade100,
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "All Payments",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                                Text(
                                  " \n( 0 ) ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
