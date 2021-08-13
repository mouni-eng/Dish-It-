import 'package:final_project2/Models/vendor_model.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:final_project2/widgets/products.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  static String id = "ProductScreen";

  final VendorModel vendorModel;

  ProductsScreen({this.vendorModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [ 
              Container(
                color: Colors.white,
                width: double.infinity,
                height: 200,
                child: Image.network(
                  vendorModel.samplePicture,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: getProportionateScreenWidth(30),
                height: getProportionateScreenHeight(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.all(getProportionateScreenWidth(20)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back),
                ),
              ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(20)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: vendorModel.name,
                  color: Colors.black,
                  size: getProportionateScreenWidth(20),
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                CustomText(
                  text: vendorModel.categorie,
                  size: getProportionateScreenWidth(16),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.motorcycle_rounded,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(10),
                    ),
                    CustomText(
                      text: "Within ${vendorModel.deliveryTime} mins",
                      color: Colors.black,
                      size: getProportionateScreenWidth(16),
                    ),
                    CustomText(
                      text: " (Delivery fee: EGP ${vendorModel.delivery})",
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(40),
                ),
                PopularProducts(vendorModel: vendorModel,),
              ],
          ),
        )
      ],
    ),
            )));
  }
}
