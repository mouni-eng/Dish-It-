import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project2/Models/vendor_model.dart';
import 'package:final_project2/Screens/products_screen.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/services/home_service.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ResturantCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Container(
          height: getProportionateScreenHeight(500),
          child: StreamBuilder<QuerySnapshot>(
            stream: HomeService().getVendor(),
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
                  )
                ],
              );
            },
          ),
        ));
  }
}

class ResturantCards extends StatelessWidget {
  final int length;
  final String logo, samplepic, categorie, name, delevery, deleveryTime;

  ResturantCards({
    this.name,
    this.samplepic,
    this.logo,
    this.categorie,
    this.length,
    this.delevery,
    this.deleveryTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductsScreen(
                        vendorModel: VendorModel(
                          name: name,
                          categorie: categorie,
                          logo: logo,
                          samplePicture: samplepic,
                          delivery: delevery,
                          deliveryTime: deleveryTime,
                        ),
                      )));
        },
        child: Container(
          width: double.infinity,
          height: getProportionateScreenHeight(400),
          margin: EdgeInsets.all(getProportionateScreenWidth(10)),
          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
          decoration: BoxDecoration(
            color: Colors.grey[100],
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                width: double.infinity,
                height: getProportionateScreenHeight(250),
                child: Image.network(
                  samplepic,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: categorie,
                    size: getProportionateScreenWidth(14),
                  ),
                  CustomText(
                    text: "Within 27 mins",
                    size: getProportionateScreenWidth(14),
                    color: Colors.black,
                  )
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: name,
                        size: getProportionateScreenWidth(18),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Row(
                        children: [
                          Icon(Icons.sentiment_satisfied_outlined),
                          SizedBox(
                            width: getProportionateScreenWidth(5),
                          ),
                          CustomText(
                            text: "Very good",
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: getProportionateScreenWidth(60),
                    height: getProportionateScreenHeight(60),
                    child: Image.network(logo),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
