import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project2/Models/order_model.dart';
import 'package:final_project2/Models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FireBaseUser {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _ordersCollectionRef =
      FirebaseFirestore.instance.collection('clientsOrders');

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

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

  Future<void> updateUserAddress(String addressLine, uid) async {
    await _firestore
        .collection("users")
        .doc(uid)
        .update({"addressLine": addressLine});
  }

  Future<void> uploadProfilePic(File image, String uid) async {
    Reference ref = _firebaseStorage.ref().child(basename(image.path));
    await ref.putFile(image);
    String url = await ref.getDownloadURL();
    print(url);
    await _firestore.collection("users").doc(uid).update({"pic": url});
  }
}
