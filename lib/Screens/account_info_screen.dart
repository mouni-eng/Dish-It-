import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/auth_view_model.dart';
import 'package:final_project2/view_models/loacation_view_model.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountInfo extends StatelessWidget {
  static String id = "AccountInfo";
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, profile, child) => Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: "Account Info",
            size: getProportionateScreenWidth(20),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),
              CustomInfo(
                property: profile.userModel.name,
                info: "Name:",
              ),
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),
              CustomInfo(
                property: profile.userModel.lastName,
                info: "Last Name:",
              ),
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),
              CustomInfo(
                property: profile.userModel.email,
                info: "Email:",
              ),
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),
              CustomInfo(
                property: Provider.of<LocationViewModel>(context).addressLine = null ? "unKown" : Provider.of<LocationViewModel>(context).addressLine,
                info: "Address:",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomInfo extends StatelessWidget {
  final String property, info;

  CustomInfo({this.property, this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(14)),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFFF5F6F9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: info,
            color: Colors.black,
            size: getProportionateScreenWidth(18),
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            width: getProportionateScreenWidth(14),
          ),
          Expanded(
            child: CustomText(
              text: property,
              color: Colors.black,
              size: getProportionateScreenWidth(16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
