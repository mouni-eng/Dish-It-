import 'package:final_project2/Models/category_model.dart';
import 'package:final_project2/services/home_service.dart';
import 'package:flutter/material.dart';

class CategoryViewModel extends ChangeNotifier {
  List<CategoryModel> _categorylist = [];
  List<CategoryModel> get categoryList {
    return _categorylist;
  }

  CategoryViewModel() {
    getCategories();
  }

  getCategories() async {
    await HomeService().getCategory().then((value) {
      for (int i = 0; i < value.length; i++) {
        _categorylist.add(CategoryModel.fromJason(value[i].data()));
      }
      notifyListeners();
    });
  }
}
