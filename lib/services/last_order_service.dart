import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LastOrders {
  final CollectionReference _lastOrdersRef =
      FirebaseFirestore.instance.collection('clientsOrders');

  getLastOrders() {
    User user = FirebaseAuth.instance.currentUser;
    var value =
        _lastOrdersRef.where("email", isEqualTo: user.email).snapshots();
    return value;
  }

  
}
