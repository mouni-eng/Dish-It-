class OrderModel {
  List<dynamic> prId;
  String totalPrice;
  String name;
  String lastName;
  String phoneNumber;
  String address;
  List<dynamic> image;
  List<dynamic> title;
  List<dynamic> price;
  String email;

  OrderModel({
    this.prId,
    this.name,
    this.lastName,
    this.address,
    this.phoneNumber,
    this.totalPrice,
    this.image,
    this.title,
    this.price,
    this.email,
  });

  OrderModel.fromjson(Map<dynamic, dynamic> map) {
    prId = map["prId"];
    image = map["image"];
    name = map["name"];
    lastName = map["lastName"];
    phoneNumber = map["phoneNumber"];
    address = map["address"];
    totalPrice = map["totalPrice"];
    title = map["title"];
    price = map["price"];
    email = map["email"];
  }

  toJson() {
    return {
      'prId': prId,
      'totalPrice': totalPrice,
      'name': name,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address,
      'image': image,
      'title': title,
      'price': price,
      'email': email,
    };
  }
}
