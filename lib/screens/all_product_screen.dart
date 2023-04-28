import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_admin/screens/product_details_screen.dart';

import '../animations/fade_animation.dart';
import '../widgets/cart_widget.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All QC Verified Product",
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
                        .collection("products")
                        .where("isDetailsCompleted", isEqualTo: true)
                        .where("active", isEqualTo: true)
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ProductDetailsScreen(
                                        code: "1",
                                          snap: snapshot.data!.docs[index]
                                              .data())));
                            },
                            child: Container(
                              child: FadeAnimation(
                                1.1,
                                CartWidget(
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
