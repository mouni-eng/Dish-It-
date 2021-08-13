import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project2/Models/product_model.dart';
import 'package:final_project2/Models/vendor_model.dart';
import 'package:final_project2/Screens/details_screen.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/services/home_service.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:final_project2/widgets/products.dart';
import 'package:flutter/material.dart';

class AllProductsScreen extends StatelessWidget {
  static String id = "AllProductsScreen";
  final VendorModel vendor;
  AllProductsScreen({this.vendor});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: vendor.name,
          size: getProportionateScreenWidth(20),
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(15)),
          child: StreamBuilder<QuerySnapshot>(
            stream: HomeService().getProducts(vendor.name),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ));
              }
              final allproducts = snapshot.data.docs;
              List<ProductsCard> allProductsList = [];
              for (var product in allproducts) {
                final productModel = Product.fromJason(product.data());
                final productCard = ProductsCard(
                  productmodel: productModel,
                  vendorModel: vendor,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                                  product: productModel,
                                )));
                  },
                );
                allProductsList.add(productCard);
              }
              return allProductsList.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "There is no Avalible Products right now",
                          size: getProportionateScreenWidth(20),
                        )
                      ],
                    )
                  : GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      children: allProductsList,
                    );
            },
          )),
    );
  }
}
