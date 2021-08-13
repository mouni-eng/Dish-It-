import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  final CollectionReference _categoryCollectionRef =
      FirebaseFirestore.instance.collection('categories');
  final CollectionReference _productCollectionRef =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference _vendorCollectionRef =
      FirebaseFirestore.instance.collection('Vendors');
  final CollectionReference _specialOffers =
      FirebaseFirestore.instance.collection('sliderOffer');

  Future<List<QueryDocumentSnapshot>> getCategory() async {
    var value = await _categoryCollectionRef.get();
    return value.docs;
  }

  getSpecialOffers() {
    var value = _specialOffers.snapshots();
    return value;
  }

  getPopularProduct(String vendor) {
    var value = _productCollectionRef
        .where("isPopular", isEqualTo: true)
        .where("vendor", isEqualTo: vendor)
        .snapshots();
    return value;
  }

  getProducts(String vendor) {
    var value =
        _productCollectionRef.where("vendor", isEqualTo: vendor).snapshots();
    return value;
  }

  getVendor() {
    var value = _vendorCollectionRef.snapshots();
    return value;
  }

  getSpecificVendors(String categorie) {
    var value = _vendorCollectionRef
        .where("Categorie", isEqualTo: categorie)
        .snapshots();
    return value;
  }

  searchProduct(String searchKey) {
    var value = FirebaseFirestore.instance
        .collection('Vendors')
        .where('Name', isGreaterThanOrEqualTo: searchKey)
        .where('Name', isLessThan: searchKey + 'z')
        .snapshots();
    return value;
  }
}
