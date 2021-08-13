import 'package:final_project2/size_config.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static String id = "NotificationScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Notifications",
          size: getProportionateScreenWidth(20),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CustomText(
              text: "Service is Currently Unavalibale",
            ),
          )
        ],
      ),
    );
  }
}
