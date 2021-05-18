class CartModel {
  String name;
  String pic;
  String price;
  String id;
  int quantity;
  CartModel({this.name, this.id, this.pic, this.price, this.quantity = 1});

  CartModel.fromjson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    name = map['Name'];
    pic = map['Pic'];
    price = map['Price'];
    id = map['id'];
    quantity = map['quantity'];
  }

  tojson() {
    return {
      'name': name,
      'pic': pic,
      'price': price,
      'id': id,
      'quantity': quantity,
    };
  }
}