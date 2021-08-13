import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project2/Screens/cart_screen.dart';
import 'package:final_project2/Screens/search_screen.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/services/home_service.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/auth_view_model.dart';
import 'package:final_project2/view_models/loacation_view_model.dart';
import 'package:final_project2/widgets/bottom_nav_bar.dart';
import 'package:final_project2/widgets/category.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:final_project2/widgets/icon_btn.dart';
import 'package:final_project2/widgets/resturant_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  static String id = "HomeScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.12,
                      decoration: BoxDecoration(
                        color: kSecondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SearchField(),
                    ),
                    Destination(),
                    IconBtnWithCounter(
                      svgSrc: "assets/icons/Cart Icon.svg",
                      press: () => Navigator.pushNamed(context, CartScreen.id),
                    ),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(40)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: CustomText(
                  text:
                      "What would you like to\n order, ${Provider.of<AuthViewModel>(context).userModel == null ? null : Provider.of<AuthViewModel>(context).userModel.name}?",
                  color: Colors.black,
                  size: getProportionateScreenWidth(17),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Categories(),
              SizedBox(height: getProportionateScreenWidth(5)),
              ImageSlider(),
              SizedBox(height: getProportionateScreenWidth(30)),
              ResturantCard(),
              SizedBox(height: getProportionateScreenWidth(30)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, SearchScreen.id);
      },
      icon: Icon(Icons.search),
      iconSize: getProportionateScreenWidth(27),
    );
  }
}

class Destination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<LocationViewModel>(context).getAddress();
    return Container(
      width: SizeConfig.screenWidth * 0.5,
      child: Column(
        children: [
          CustomText(
            text: "Delivering to",
            size: getProportionateScreenWidth(12),
          ),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          CustomText(
            overflow: TextOverflow.ellipsis,
            text: Provider.of<LocationViewModel>(context).addressLine == null
                ? "address not found"
                : Provider.of<LocationViewModel>(context).addressLine,
            size: getProportionateScreenWidth(15),
            color: kPrimaryColor,
          )
        ],
      ),
    );
  }
}

class ImageSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: HomeService().getSpecialOffers(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            return Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              child: CarouselSlider.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index, integer) {
                    DocumentSnapshot sliderImage = snapshot.data.docs[index];
                    Map getImage = sliderImage.data();
                    return Container(
                      height: 150,
                      width: 280,
                      margin: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(8)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.network(
                        getImage['images'],
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                  options: CarouselOptions(
                    initialPage: 0,
                    autoPlay: true,
                    height: getProportionateScreenHeight(150),
                  )),
            );
          },
        )
      ],
    );
  }
}
