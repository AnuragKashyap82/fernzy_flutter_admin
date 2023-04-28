import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_admin/screens/product_details_screen.dart';
import 'package:frenzy_admin/widgets/cart_widget.dart';

import '../animations/fade_animation.dart';

class NewQCProductScreen extends StatefulWidget {
  const NewQCProductScreen({Key? key}) : super(key: key);

  @override
  State<NewQCProductScreen> createState() => _NewQCProductScreenState();
}

class _NewQCProductScreenState extends State<NewQCProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New QC Product",
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
                        .where("active", isEqualTo: false)
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
                                            code: "2",
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
