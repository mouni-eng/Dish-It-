class AddressModel {
  String street;
  String buildingnumber;
  String floornumber;
  String appartmentnumber;
  String phonenumber;

  AddressModel(
      {this.street,
      this.buildingnumber,
      this.floornumber,
      this.appartmentnumber,
      this.phonenumber});

  AddressModel.fromjson(Map<dynamic, dynamic> map) {
    street = map["street"];
    buildingnumber = map["buildingnumber"];
    floornumber = map["floornumber"];
    appartmentnumber = map["appartmentnumber"];
    phonenumber = map["phonenumber"];
  }

  toJson() {
    return {
      'street': street,
      'buildingnumber': buildingnumber,
      'floornumber': floornumber,
      'appartmentnumber': appartmentnumber,
      'phonenumber': phonenumber,
    };
  }
}
