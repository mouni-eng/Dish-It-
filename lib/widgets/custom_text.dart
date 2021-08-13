import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign aligment;
  final double height;
  final TextDecoration decoration;
  final TextOverflow overflow;

  CustomText({
    this.fontWeight = FontWeight.normal,
    this.size,
    this.text,
    this.color,
    this.aligment,
    this.height = 1,
    this.decoration,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        overflow: overflow,
        textAlign: aligment,
        style: TextStyle(
          fontSize: size,
          fontWeight: fontWeight,
          color: color,
          height: height,
          decoration: decoration,
        ),
      ),
    );
  }
}
