import 'package:final_project2/constants.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onpressed;
  final double size;
  final double radius;

  CustomButton({this.text, this.onpressed, this.size, this.radius});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      color: kPrimaryColor,
      padding: EdgeInsets.all(20),
      onPressed: onpressed,
      child: CustomText(
        text: text,
        size: size,
        color: Colors.white,
        aligment: TextAlign.center,
      ),
    );
  }
}
