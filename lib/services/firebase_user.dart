import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project2/Models/cart_model.dart';
import 'package:final_project2/Models/order_model.dart';
import 'package:final_project2/Models/user_model.dart';

class FireBaseUser {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _ordersCollectionRef =
      FirebaseFirestore.instance.collection('clientsOrders');

  Future<void> adduser(UserModel userModel) async {
    await _firestore
        .collection('users')
        .doc(userModel.userId)
        .set(userModel.toJson());
  }

  Future<void> addUserOrders(OrderModel cartModels) async {
    await _ordersCollectionRef.add(cartModels.toJson());
  }

  Future<Map> getCurrentOrders(String email) async {
    var data = await _ordersCollectionRef.doc(email).get();
    return data.data();
  }

  Future<DocumentSnapshot> getCurrentUser(String uid) async {
    return await _firestore.collection("users").doc(uid).get();
  }
}
