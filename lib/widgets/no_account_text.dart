import 'package:final_project2/Screens/sign_up_screen.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class NoAccountText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: "Don’t have an account? ",
          size: getProportionateScreenWidth(16),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, SignUpScreen.id);
          },
          child: CustomText(
            text: "Sign Up",
            color: kPrimaryColor,
            size: getProportionateScreenWidth(16),
          ),
        )
      ],
    );
  }
}
