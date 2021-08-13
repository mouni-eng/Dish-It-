import 'package:final_project2/Models/product_model.dart';
import 'package:flutter/material.dart';

class ProductViewModel extends ChangeNotifier {
  List<Product> productsList = [];
  List<Product> favouriteList = [];

  addProducts(Product productModel) {
    productsList.add(productModel);
    notifyListeners();
  }

  toggleFavourite(int index) {
    productsList[index].isFavourite = !productsList[index].isFavourite;
    notifyListeners();
  }

  deleteFavourite() {
    favouriteList.removeWhere((element) => element.isFavourite = false);
    notifyListeners();
  }
}
