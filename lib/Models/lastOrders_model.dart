class LastOrderModel {
  String prId;
  String totalPrice;
  String name;
  String lastName;
  String phoneNumber;
  String address;
  String image;

  LastOrderModel({
    this.prId,
    this.name,
    this.lastName,
    this.address,
    this.phoneNumber,
    this.totalPrice,
    this.image,
  });

  LastOrderModel.fromjson(Map<dynamic, dynamic> map) {
    prId = map["prId"];
    image = map["image"];
    name = map["name"];
    lastName = map["lastName"];
    phoneNumber = map["phoneNumber"];
    address = map["address"];
    totalPrice = map["totalPrice"];
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
    };
  }
}