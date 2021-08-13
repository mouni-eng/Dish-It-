import 'package:final_project2/Models/product_model.dart';
import 'package:final_project2/Models/vendor_model.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/services/database_favourites.dart';
import 'package:final_project2/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FavouriteViewModel extends ChangeNotifier {
  bool loading = false;

  List<Product> _product = [];

  List<Product> _listProduct = [];

  List<Product> get favProductList {
    return _product;
  }

  FavouriteViewModel() {
    getAllProduct();
  }

  getAllProduct() async {
    loading = true;
    var dbHelper = FavouriteDatabase.db;
    var maps = await dbHelper.getallProducts();
    for (var map in maps) {
      _listProduct.add(Product.fromJason(map));
    }
    _product = _listProduct;
    loading = false;
    notifyListeners();
  }

  Future<void> addProducts(
      Product model, VendorModel vendorModel, BuildContext context) async {
    for (var item in _product) {
      if (item.title == model.title) {
        return Fluttertoast.showToast(
            msg: "Product already in favourite",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: getProportionateScreenWidth(16));
      }
    }
    Product productmodel = Product(
        id: model.id,
        description: model.description,
        title: model.title,
        vendor: vendorModel.name,
        deleivery: vendorModel.delivery,
        deleiveryTime: vendorModel.deliveryTime,
        logo: vendorModel.logo,
        rating: model.rating,
        price: model.price,
        images: model.images);
    var dbHelper = FavouriteDatabase.db;
    await dbHelper.insert(productmodel);
    _product.add(model);
    notifyListeners();
    return Fluttertoast.showToast(
        msg: "Product added to Favourites",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: kPrimaryColor,
        textColor: Colors.white,
        fontSize: getProportionateScreenWidth(16));
  }

  dismissible(Product model, int index) async {
    var dbHelper = FavouriteDatabase.db;
    await dbHelper.deleteDog(model.id);
    _product.removeAt(index);
    notifyListeners();
  }
}
