import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/auth_view_model.dart';
import 'package:final_project2/widgets/custom_button.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:final_project2/widgets/custom_textformfield.dart';
import 'package:final_project2/widgets/no_account_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatelessWidget {
  static String id = "forgetPassword";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String email;
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Consumer<AuthViewModel>(
          builder: (context, auth, child) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(18)),
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  CustomText(
                    text: "Forgot Password",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    size: getProportionateScreenWidth(28),
                  ),
                  CustomText(
                    text:
                        "Please enter your email and we will send \nyou a link to return to your account",
                    aligment: TextAlign.center,
                    height: 1.5,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.1),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          obscure: false,
                          labelText: "Email",
                          hintText: "Enter your Email",
                          image: "assets/icons/Mail.svg",
                          onsaved: (value) {
                            email = value;
                          },
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.1),
                        SizedBox(
                          width: double.infinity,
                          child: Builder(
                            builder: (context) => CustomButton(
                                text: "Continue",
                                size: getProportionateScreenWidth(18),
                                radius: 20,
                                onpressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    // if all are valid then go to success screen
                                    try {
                                      await auth.resetPassword(email);
                                      Navigator.pop(context);
                                    } catch (e) {
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text(e.toString())));
                                    }
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.3),
                  NoAccountText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
