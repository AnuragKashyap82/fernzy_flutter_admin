import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_details_model.dart';

class FireStoreMethods {

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future uploadUserDetailsToDb({required UserDetailsModel user}) async {
    await firebaseFirestore
        .collection("admin")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(user.getJson());
  }

  Future verifySellerAccount({
    required String shopId,
  }) async {
    await firebaseFirestore
        .collection("sellers")
        .doc(shopId)
        .update({
      "isVerified": true,
    });
  }

  Future approveQc({
    required String productId,
  }) async {
    await firebaseFirestore
        .collection("products")
        .doc(productId)
        .update({
      "active": true,
    });
  }

}
