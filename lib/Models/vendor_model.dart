class VendorModel {
  String categorie, email, logo, name, samplePicture, searchkey, delivery, deliveryTime;

  VendorModel(
      {this.categorie,
      this.logo,
      this.name,
      this.email,
      this.samplePicture,
      this.searchkey, this.delivery, this.deliveryTime});

  VendorModel.fromjson(Map<dynamic, dynamic> map) {
    categorie = map["Categorie"];
    email = map["Email"];
    logo = map["Logo"];
    name = map["Name"];
    samplePicture = map["Sample picture"];
    searchkey = map["searchkey"];
    delivery = map["delivery"];
    deliveryTime = map["deliveryTime"];
  }

  toJson() {
    return {
      'Categorie': categorie,
      'Email': email,
      'Logo': logo,
      'Name': name,
      'Sample picture': samplePicture,
      'searchkey': searchkey,
      'delivery': delivery,
      'deliveryTime': deliveryTime,
    };
  }
}
