import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_admin/screens/verified_seller_account_details.dart';
import 'package:frenzy_admin/widgets/seller_verify_widget.dart';

import '../animations/fade_animation.dart';

class VerifiedSellerScreen extends StatefulWidget {
  const VerifiedSellerScreen({Key? key}) : super(key: key);

  @override
  State<VerifiedSellerScreen> createState() => _VerifiedSellerScreenState();
}

class _VerifiedSellerScreenState extends State<VerifiedSellerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Verified Seller",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body:  SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: PhysicalModel(
            color: Colors.white,
            shadowColor: Colors.blue,
            elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("sellers")
                    .where("isVerified", isEqualTo: true)
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        );
                      }
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      VerifiedSellerAccountDetails(
                                          snap: snapshot.data!.docs[index]
                                              .data())));
                            },
                            child: Container(
                              child: FadeAnimation(
                                1.1,
                                SellerVerifyWidget(
                                  snap:
                                  snapshot.data!.docs[index].data(),
                                ),
                              ),
                            ),
                          ));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
