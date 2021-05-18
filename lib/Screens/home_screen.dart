import 'package:final_project2/Screens/cart_screen.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/widgets/bottom_nav_bar.dart';
import 'package:final_project2/widgets/category.dart';
import 'package:final_project2/widgets/icon_btn.dart';
import 'package:final_project2/widgets/products.dart';
import 'package:final_project2/widgets/section_title.dart';
import 'package:final_project2/widgets/special_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String id = "HomeScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.6,
                      decoration: BoxDecoration(
                        color: kSecondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        onChanged: (value) => print(value),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20),
                                vertical: getProportionateScreenWidth(9)),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Search product",
                            prefixIcon: Icon(Icons.search)),
                      ),
                    ),
                    IconBtnWithCounter(
                      svgSrc: "assets/icons/Cart Icon.svg",
                      press: () => Navigator.pushNamed(context, CartScreen.id),
                    ),
                    IconBtnWithCounter(
                      svgSrc: "assets/icons/Bell.svg",
                      numOfitem: 3,
                      press: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(10)),
              Container(
                // height: 90,
                width: double.infinity,
                margin: EdgeInsets.all(getProportionateScreenWidth(20)),
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenWidth(15),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF4A3298),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(text: "A Summer Surpise\n"),
                      TextSpan(
                        text: "Cashback 20%",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(24),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Categories(),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: SectionTitle(
                      title: "Special for you",
                      press: () {},
                    ),
                  ),
                  SizedBox(height: getProportionateScreenWidth(20)),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SpecialOfferCard(
                          image: "assets/images/Image Banner 2.png",
                          category: "Smartphone",
                          numOfBrands: 18,
                          press: () {},
                        ),
                        SpecialOfferCard(
                          image: "assets/images/Image Banner 3.png",
                          category: "Fashion",
                          numOfBrands: 24,
                          press: () {},
                        ),
                        SizedBox(width: getProportionateScreenWidth(20)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenWidth(30)),
              PopularProducts(),
              SizedBox(height: getProportionateScreenWidth(30)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
