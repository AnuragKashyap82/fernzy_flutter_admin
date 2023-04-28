
import 'package:flutter/material.dart';
import 'package:frenzy_admin/resources/firestore_methods.dart';

import '../widgets/all_details_widgets.dart';
import '../widgets/product_details_widget.dart';
import '../widgets/rewards_widgets.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String code;
  final snap;

  const ProductDetailsScreen({Key? key,  required this.code, required this.snap,}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.snap['productTitle'],
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              child: Column(
                children: [
                  ProductDetailsWidget(snap: widget.snap),
                  SizedBox(
                    height: 8,
                  ),
                  RewardsWidgets(),
                  SizedBox(
                    height: 8,
                  ),
                  AllDetailsWidgets(snap: widget.snap),
                  SizedBox(
                    height: 80,
                  ),
                  // TabLayout()
                ],
              ),
            ),
          ),
          widget.code == "1" ? Container():
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child:
            Container(
                    height: 50.0,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            height: 50,
                            width: screenSize.width / 2,
                            color: Colors.white,
                            child: Center(
                              child: _isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.blue,
                                    ))
                                  : Text(
                                    "Reject QC",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            _showApproveQCDialog();
                          },
                          child: Container(
                            height: 50,
                            width: screenSize.width / 2,
                            color: Colors.blue,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Approve QC",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )

          ),
        ],
      ),
    );
  }

  void _showApproveQCDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 24,
                        )),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "This Product will be now visible to the Users",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.snap['productTitle'],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          FireStoreMethods().approveQc(productId: widget.snap['productId'])
                              .then((value) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          height: 42,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                            "Approve",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 42,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                            "Cancel",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ));
  }
}
