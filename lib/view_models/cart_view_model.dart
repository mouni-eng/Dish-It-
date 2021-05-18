import 'package:final_project2/Models/cart_model.dart';
import 'package:final_project2/services/database_helper.dart';
import 'package:flutter/material.dart';

class CartViewModel extends ChangeNotifier {
  bool loading = false;

  double _totalPrice = 0.0;

  double get totalPrice {
    return _totalPrice;
  }

  List<CartModel> _cartProductModel1 = [];

  List<CartModel> _list = [];

  List<CartModel> get cartProductModel {
    return _cartProductModel1;
  }

  CartViewModel() {
    getAllProduct();
  }

  getTotalPrice() {
    for (var item in _cartProductModel1) {
      _totalPrice += double.parse(item.price) * item.quantity;
      notifyListeners();
    }
  }

  getAllProduct() async {
    loading = true;
    var dbHelper = CartDatabase.db;
    var maps = await dbHelper.getallProducts();
    for (var map in maps) {
      _list.add(CartModel.fromjson(map));
    }
    _cartProductModel1 = _list;
    getTotalPrice();
    loading = false;
    notifyListeners();
  }

  Future<void> addProducts(CartModel model) async {
    for (var item in _cartProductModel1) {
      if (item.name == model.name) {
        return;
      }
    }
    var dbHelper = CartDatabase.db;
    await dbHelper.insert(model);
    _cartProductModel1.add(model);
    _totalPrice += double.parse(model.price) * model.quantity;
    notifyListeners();
  }

  increaseQuantity(int index) async {
    var dbHelper = CartDatabase.db;
    _cartProductModel1[index].quantity++;
    _totalPrice += double.parse(_cartProductModel1[index].price);
    await dbHelper.updateCart(_cartProductModel1[index]);
    notifyListeners();
  }

  decreaseQuantity(int index) async {
    var dbHelper = CartDatabase.db;
    _cartProductModel1[index].quantity--;
    _totalPrice -= double.parse(_cartProductModel1[index].price);
    await dbHelper.updateCart(_cartProductModel1[index]);
    notifyListeners();
  }

  dismissible(CartModel model, int index) async {
    var dbHelper = CartDatabase.db;
    await dbHelper.deleteDog(int.parse(model.id));
    _totalPrice -= double.parse(_cartProductModel1[index].price);
    cartProductModel.removeAt(index);
    notifyListeners();
  }

}
