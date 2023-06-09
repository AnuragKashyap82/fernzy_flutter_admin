import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_admin/screens/new_qc_product_screen.dart';
import 'package:frenzy_admin/screens/new_seller_verification_screen.dart';
import 'package:frenzy_admin/screens/verified_seller.dart';

import '../animations/fade_animation.dart';
import '../utils/utils.dart';
import 'all_product_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _adminData = {};
  bool _isLoading = false;

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
      var userSnap = await FirebaseFirestore.instance
          .collection("admin")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (userSnap.exists) {
        setState(() {
          _adminData = userSnap.data()!;
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
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.search),
              )),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            DrawerHeader(
              padding:
              const EdgeInsets.only(top: 22, left: 8, right: 8, bottom: 8),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 34,
                      backgroundImage:
                      NetworkImage("${_adminData['photoUrl']}"),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${_adminData['name']}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${_adminData['email']}",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.shopping_bag,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Frenzy',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.category,
                  color: Colors.black87,
                ),
                title: const Text(
                  'All Category',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.add_chart_sharp,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Add Category',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.store_outlined,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Trending Store',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.add_shopping_cart_sharp,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Products',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {

                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Sell on frenzy store',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.surround_sound,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Refer & Earn',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.shopping_bag,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Orders',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {

                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Out Of Stocks',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {

                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.card_giftcard,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Rewards',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.shopping_cart,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Cart',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Wishlist',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.person,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Account',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  _addChatUserDialog();
                },
              ),
            ),
          ],
        ),
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator(strokeWidth: 2,)):
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

  void _addChatUserDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding:
          EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Icon(
                Icons.logout,
                color: Colors.blue,
              ),
              const Text("  Logout")
            ],
          ),
          content: Text(
            "Are you sure want to logout?",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut().then((value) => {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()))
                });
                Navigator.pop(context);
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            )
          ],
        ));
  }
}
