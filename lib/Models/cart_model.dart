class CartModel {
  String name;
  String pic;
  String price;
  String id;
  int quantity;
  String vendor;
  String logo;
  String deleiveryTime;
  String deleivery;


  CartModel({this.name, this.id, this.pic, this.price, this.quantity, this.deleivery, this.deleiveryTime, this.logo, this.vendor});

  CartModel.fromjson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    name = map['Name'];
    pic = map['Pic'];
    price = map['Price'];
    id = map['id'];
    quantity = map['quantity'];
    vendor = map['vendor'];
    logo = map['logo'];
    deleiveryTime = map['deleiveryTime'];
    deleivery = map['deleivery'];
  }

  tojson() {
    return {
      'name': name,
      'pic': pic,
      'price': price,
      'id': id,
      'quantity': quantity,
      'vendor': vendor,
      'logo': logo,
      'deleiveryTime': deleiveryTime,
      'deleivery': deleivery,
    };
  }
}
