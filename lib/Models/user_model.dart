class UserModel {
  String userId, email, name, pic, lastName, phoneNumber, addressLine;
  dynamic address, latitude, longitude;

  UserModel(
      {this.userId,
      this.email,
      this.name,
      this.lastName,
      this.phoneNumber,
      this.address,
      this.latitude,
      this.longitude,
      this.pic,
      this.addressLine});

  UserModel.fromjson(Map<dynamic, dynamic> map) {
    userId = map["userId"];
    email = map["email"];
    name = map["name"];
    lastName = map["lastName"];
    phoneNumber = map["phoneNumber"];
    address = map["address"];
    latitude = map["latitude"];
    longitude = map["longitude"];
    pic = map["pic"];
    addressLine = map["addressLine"];
  }

  toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'pic': pic,
      'addressLine': addressLine,
    };
  }
}
