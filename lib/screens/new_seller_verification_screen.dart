import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_admin/screens/seller_account_verification.dart';

import '../animations/fade_animation.dart';
import '../widgets/seller_verify_widget.dart';

class NewSellerVerificationScreen extends StatefulWidget {
  const NewSellerVerificationScreen({Key? key}) : super(key: key);

  @override
  State<NewSellerVerificationScreen> createState() =>
      _NewSellerVerificationScreenState();
}

class _NewSellerVerificationScreenState
    extends State<NewSellerVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Seller Verification",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                        .where("isVerified", isEqualTo: false)
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
                          itemBuilder: (context, index) =>
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          SellerAccountVerification(
                                              snap: snapshot.data!.docs[index]
                                                  .data())));
                                },
                                child: Container(
                                  child: FadeAnimation(
                                    1.1,
                                    SellerVerifyWidget(
                                      snap: snapshot.data!.docs[index].data(),
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
