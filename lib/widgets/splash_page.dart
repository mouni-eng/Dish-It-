import 'package:final_project2/constants.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  final String image;
  final String text;

  SplashPage({this.text, this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        CustomText(
          text: "TOKOTO",
          fontWeight: FontWeight.bold,
          size: getProportionateScreenWidth(36),
          color: kPrimaryColor,
        ),
        CustomText(
          text: text,
          aligment: TextAlign.center,
        ),
        Spacer(
          flex: 2,
        ),
        Image.asset(
          image,
          width: getProportionateScreenWidth(265),
          height: getProportionateScreenHeight(235),
        ),
      ],
    );
  }
}