import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project2/Models/vendor_model.dart';
import 'package:final_project2/Screens/specific_category_screen.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/services/home_service.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:final_project2/widgets/resturant_card.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static String id = "SearchScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(child: SearchWidget()),
      ),
    );
  }
}

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String searchKey;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black54,
                  size: getProportionateScreenWidth(30),
                )),
            Container(
              margin: EdgeInsets.all(getProportionateScreenWidth(10)),
              width: SizeConfig.screenWidth * 0.8,
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchKey = value;
                  });
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20),
                        vertical: getProportionateScreenWidth(9)),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Search product",
                    prefixIcon: Icon(Icons.search)),
                autofocus: true,
              ),
            ),
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Container(
              height: getProportionateScreenHeight(650),
              child: searchKey == null
                  ? Padding(
                      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Search for Resturants",
                            size: getProportionateScreenWidth(20),
                          )
                        ],
                      ),
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream: HomeService().searchProduct(searchKey),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Center(
                              child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ));
                        final vendors = snapshot.data.docs;
                        List<ResturantCards> vendorlist = [];
                        for (var vendor in vendors) {
                          final vendormodel =
                              VendorModel.fromjson(vendor.data());
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
            )),
      ],
    );
  }
}
