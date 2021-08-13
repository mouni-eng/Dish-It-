import 'package:final_project2/Models/order_model.dart';
import 'package:final_project2/services/firebase_user.dart';
import 'package:flutter/cupertino.dart';

class OrderViewModel extends ChangeNotifier {

  Future<void> addOrder(
    List<dynamic> prId,
    String totalPrice,
    name,
    lastName,
    vendor,
    logo,
    deleivery,
    deleiveryTime,
    phoneNumber,
    dynamic address,
    List<dynamic> price,
    email,
    List<dynamic> image,
    title,
  ) async {
    var orderModel = OrderModel(
      prId: prId,
      totalPrice: totalPrice,
      name: name,
      lastName: lastName,
      phoneNumber: phoneNumber,
      address: address,
      image: image,
      title: title,
      price: price,
      email: email,
      vendor: vendor,
      logo: logo,
      deleiveryTime: deleiveryTime,
      deleivery: deleivery,
    );

    await FireBaseUser().addUserOrders(orderModel);
    notifyListeners();
  }
}
