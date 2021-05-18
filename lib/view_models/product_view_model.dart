

import 'package:final_project2/Models/product_model.dart';
import 'package:final_project2/services/home_service.dart';
import 'package:flutter/material.dart';

class ProductViewModel extends ChangeNotifier {

  List<Product> _productlist = [];
  List<Product> get productlist {
    return _productlist;
  }


  ProductViewModel() {
    getProduct();
  }


  getProduct() async {
    await HomeService().getProducts().then((value) {
      for (int i = 0; i < value.length; i++) {
        _productlist.add(Product.fromJason(value[i].data()));
      }
      notifyListeners();
    });
  }
}