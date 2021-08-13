import 'package:final_project2/services/help_center_service.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/widgets/custom_button.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  static String id = "HelpScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Help Center",
          size: getProportionateScreenWidth(20),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CustomText(
              text: "In order to Ask about your order \n Please Contact us",
              aligment: TextAlign.center,
              size: getProportionateScreenWidth(20),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          CustomButton(
            onpressed: () {
              HelpCenter().launchURL();
            },
            text: "Contact US",
            radius: getProportionateScreenWidth(20),
          )
        ],
      ),
    );
  }
}
