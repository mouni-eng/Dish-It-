class UserModel {
  String userId, email, name, pic, lastName, phoneNumber, address;

  UserModel(
      {this.userId,
      this.email,
      this.name,
      this.lastName,
      this.phoneNumber,
      this.address});

  UserModel.fromjson(Map<dynamic, dynamic> map) {
    userId = map["userId"];
    email = map["email"];
    name = map["name"];
    lastName = map["lastName"];
    phoneNumber = map["phoneNumber"];
    address = map["address"];
  }

  toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}
