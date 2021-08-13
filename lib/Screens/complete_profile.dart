import 'package:final_project2/Screens/address_screen.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/auth_view_model.dart';
import 'package:final_project2/widgets/custom_button.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:final_project2/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompleteProfile extends StatelessWidget {
  static String id = "completeProfile";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String email, userId;
  CompleteProfile({this.email, this.userId});
  @override
  Widget build(BuildContext context) {
    String lastName, firstName, phoneNumber;
    return Consumer<AuthViewModel>(
      builder: (context, auth, child) => Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    CustomText(
                      text: "Complete Profile",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      size: getProportionateScreenWidth(28),
                    ),
                    CustomText(
                      text:
                          "Complete your details or continue \nwith social media",
                      aligment: TextAlign.center,
                      height: 1.5,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            obscure: false,
                            labelText: "Name",
                            hintText: "Enter your Name",
                            image: "assets/icons/User.svg",
                            onsaved: (value) {
                              firstName = value;
                            },
                            onchanged: (value) {
                              firstName = value;
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return auth.validatetext("Enter your Name");
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          CustomTextFormField(
                            obscure: false,
                            labelText: "Last Name",
                            hintText: "Enter your Last Name",
                            image: "assets/icons/User.svg",
                            onsaved: (value) {
                              lastName = value;
                            },
                            onchanged: (value) {
                              lastName = value;
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return auth
                                    .validatetext("Enter your Last Name");
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          CustomTextFormField(
                            obscure: false,
                            labelText: "Phone Number",
                            hintText: "Enter your Phone Number",
                            image: "assets/icons/Phone.svg",
                            onsaved: (value) {
                              phoneNumber = value;
                            },
                            onchanged: (value) {
                              phoneNumber = value;
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return auth
                                    .validatetext("Enter your Phone Number");
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(30),
                          ),
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddressScreen(
                                                    firstname: firstName,
                                                    lastname: lastName,
                                                    email: email,
                                                    phoneNumber: phoneNumber,
                                                    userid: userId,
                                                  )));
                                    }
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Text(
                      'By continuing your confirm that you agree \nwith our Term and Condition',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
