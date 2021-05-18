import 'package:final_project2/Models/lastOrders_model.dart';
import 'package:final_project2/Models/order_model.dart';
import 'package:final_project2/services/firebase_user.dart';
import 'package:final_project2/services/orders_database.dart';
import 'package:flutter/cupertino.dart';

class OrderViewModel extends ChangeNotifier {
  List<LastOrderModel> orderList = [];

  List<LastOrderModel> _list = [];

  bool loading = false;

  OrderViewModel() {
    getAllProduct();
  }

  Future<void> addOrder(
    List<dynamic> prId,
    String totalPrice,
    name,
    lastName,
    phoneNumber,
    address,
    price,
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
    );

    await FireBaseUser().addUserOrders(orderModel);
    notifyListeners();
  }

  getAllProduct() async {
    loading = true;
    var dbHelper = OrderDatabase.db;
    var maps = await dbHelper.getallOrders();
    for (var map in maps) {
      _list.add(LastOrderModel.fromjson(map));
    }
    orderList = _list;
    loading = false;
    notifyListeners();
  }

  Future<void> addOrders(LastOrderModel model) async {
    var dbHelper = OrderDatabase.db;
    await dbHelper.insert2(model);
    orderList.add(model);
    notifyListeners();
  }
}
