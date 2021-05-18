import 'package:flutter/material.dart';

class Product {
  int id;
  String title, description;
  List<dynamic> images;
  List<dynamic> colors;
  bool isPopular;
  double rating, price;

  Product({
    @required this.id,
    @required this.images,
    @required this.colors,
    this.rating = 0.0,
    @required this.title,
    @required this.price,
    @required this.description,
    this.isPopular = false,
  });

  Product.fromJason(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    title = map['title'];
    images = List.generate(3, (index) => map['colors'][index]);
    price = map['price'];
    isPopular = map['isPopular'];
    colors = List.generate(3, (index) => int.parse("${map['images'][index]}"));
    description = map['description'];
    rating = map['rating'];
  }
}
