import 'package:flutter/material.dart';

class Product {
  int id;
  String title, description;
  List<String> images;
  bool isPopular;
  String rating, price;
  bool isFavourite;
  String vendor;
  String logo;
  String deleiveryTime;
  String deleivery;

  Product({
    @required this.id,
    this.rating = "0.0",
    @required this.title,
    @required this.price,
    @required this.description,
    this.isPopular = false,
    this.images,
    this.isFavourite,
    this.deleivery,
    this.vendor,
    this.deleiveryTime,
    this.logo,
  });

  Product.fromJason(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    title = map['title'];
    images = List.generate(3, (index) => map['images'][index]);
    price = map['price'];
    isPopular = map['isPopular'];
    description = map['description'];
    rating = map['rating'];
    deleivery = map['deleivery'];
    vendor = map['vendor'];
    deleiveryTime = map['deleiveryTime'];
    logo = map['logo'];
  }

  tojson() {
    return {
      'id': id,
      'title': title,
      'images': images[0],
      'price': price,
      'rating': rating,
      'description': description,
      'vendor': vendor,
      'logo': logo,
      'deleiveryTime': deleiveryTime,
      'deleivery': deleivery,
    };
  }
}
