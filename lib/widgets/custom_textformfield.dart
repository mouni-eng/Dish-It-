import 'package:final_project2/constants.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String image;
  final bool obscure;
  final Function onsaved;
  final Function validate;
  final Function onchanged;

  CustomTextFormField({
    this.labelText,
    this.hintText,
    this.image,
    this.obscure,
    this.onsaved,
    this.validate,
    this.onchanged,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, auth, child) => TextFormField(
        obscureText: obscure,
        onSaved: onsaved,
        validator: validate,
        onChanged: onchanged,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: kTextColor),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 42,
            vertical: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              getProportionateScreenWidth(20),
              getProportionateScreenWidth(20),
              getProportionateScreenWidth(20),
            ),
            child: SvgPicture.asset(
              image,
              height: getProportionateScreenHeight(18),
            ),
          ),
        ),
      ),
    );
  }
}
