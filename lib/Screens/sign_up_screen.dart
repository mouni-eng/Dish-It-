import 'package:final_project2/Screens/complete_profile.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/auth_view_model.dart';
import 'package:final_project2/widgets/custom_button.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:final_project2/widgets/custom_textformfield.dart';
import 'package:final_project2/widgets/social_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  static String id = "SignUpScrren";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String email, password, conform_password;
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
                      text: "Register Account",
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
                            labelText: "Email",
                            hintText: "Enter your Email",
                            image: "assets/icons/Mail.svg",
                            onsaved: (value) {
                              email = value;
                            },
                            onchanged: (value) {
                              email = value;
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return auth.validatetext("Enter your Email");
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          CustomTextFormField(
                            obscure: true,
                            labelText: "Password",
                            hintText: "Enter your Password",
                            image: "assets/icons/Lock.svg",
                            onsaved: (value) {
                              password = value;
                            },
                            onchanged: (value) {
                              password = value;
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return auth.validatetext("Enter your Password");
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          CustomTextFormField(
                            obscure: true,
                            labelText: "Confirm Password",
                            hintText: "Re-enter your password",
                            image: "assets/icons/Lock.svg",
                            onsaved: (value) {
                              conform_password = value;
                            },
                            onchanged: (value) {
                              conform_password = value;
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return auth.validatetext("Enter your Password");
                              } else if (password != value) {
                                return auth
                                    .validatetext("Re-enter your password");
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
                                      try {
                                        var user =
                                            await auth.signUp(email, password);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CompleteProfile(
                                                      userId: user.uid,
                                                      email: user.email,
                                                    )));
                                      } catch (e) {
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                content: Text(e.toString())));
                                      }
                                    }
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialCard(
                          image: "assets/icons/facebook-2.svg",
                          press: () async {
                            try {
                              var user = await auth.getfacebook();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CompleteProfile(
                                            userId: user,
                                            email: email,
                                          )));
                            } catch (e) {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          },
                        ),
                        SocialCard(
                          image: "assets/icons/google-icon.svg",
                          press: () async {
                            try {
                              var user = await auth.getgoogleacc();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CompleteProfile(
                                            userId: user,
                                            email: email,
                                          )));
                            } catch (e) {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          },
                        ),
                        SocialCard(
                          image: "assets/icons/twitter.svg",
                          press: () {},
                        ),
                      ],
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
