import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project2/Models/vendor_model.dart';
import 'package:final_project2/Screens/products_screen.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/services/home_service.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:final_project2/widgets/resturant_card.dart';
import 'package:flutter/material.dart';

class SpecificCategory extends StatelessWidget {
  static String id = "SpecificCategory";
  final String categorie;
  SpecificCategory({this.categorie});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "$categorie Resturants",
          size: getProportionateScreenWidth(20),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          SpecificResturantCard(
            categorie: categorie,
          ),
        ],
      ),
    );
  }
}

class SpecificResturantCard extends StatelessWidget {
  final String categorie;
  SpecificResturantCard({this.categorie});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Container(
            height: getProportionateScreenHeight(650),
            child: StreamBuilder<QuerySnapshot>(
              stream: HomeService().getSpecificVendors(categorie),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                      child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ));
                final vendors = snapshot.data.docs;
                List<ResturantCards> vendorlist = [];
                for (var vendor in vendors) {
                  final vendormodel = VendorModel.fromjson(vendor.data());
                  final resturantCard = ResturantCards(
                    length: snapshot.data.docs.length,
                    logo: vendormodel.logo,
                    samplepic: vendormodel.samplePicture,
                    categorie: vendormodel.categorie,
                    name: vendormodel.name,
                    delevery: vendormodel.delivery,
                    deleveryTime: vendormodel.deliveryTime,
                  );
                  vendorlist.add(resturantCard);
                }
                return Column(
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: "Resturants",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          size: getProportionateScreenWidth(18),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(5),
                        ),
                        CustomText(
                          text: "(${snapshot.data.docs.length})",
                          size: getProportionateScreenWidth(18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    Expanded(
                      child: ListView(
                        children: vendorlist,
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}


