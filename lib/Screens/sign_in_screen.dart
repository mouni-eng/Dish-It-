import 'package:final_project2/Screens/forget_password_screen.dart';
import 'package:final_project2/Screens/loginsucces_screen.dart';
import 'package:final_project2/Screens/map_screen.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/auth_view_model.dart';
import 'package:final_project2/view_models/loacation_view_model.dart';
import 'package:final_project2/widgets/custom_button.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:final_project2/widgets/custom_textformfield.dart';
import 'package:final_project2/widgets/no_account_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignInScreen extends StatefulWidget {
  static String id = "SignInScreen";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    return Consumer<AuthViewModel>(
      builder: (context, auth, child) => ModalProgressHUD(
        inAsyncCall: auth.loading,
        progressIndicator: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Sign In"),
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
                  child: Builder(
                    builder: (context) => Column(
                      children: [
                        SizedBox(height: SizeConfig.screenHeight * 0.04),
                        CustomText(
                          text: "Welcome Back",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          size: getProportionateScreenWidth(28),
                        ),
                        CustomText(
                          text:
                              "Sign in with your email and password  \nor continue with social media",
                          aligment: TextAlign.center,
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
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return auth
                                        .validatetext("Enter your Email");
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
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return auth
                                        .validatetext("Enter your Password");
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(20),
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: auth.remember,
                                    onChanged: (value) {
                                      auth.checkBox(value);
                                    },
                                    activeColor: kPrimaryColor,
                                  ),
                                  CustomText(
                                    text: "Remember me",
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, ForgetPassword.id);
                                    },
                                    child: CustomText(
                                      text: "Forgot Password",
                                      decoration: TextDecoration.underline,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: CustomButton(
                                    text: "Continue",
                                    size: getProportionateScreenWidth(18),
                                    radius: 20,
                                    onpressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        // if all are valid then go to success screen
                                        try {
                                          auth.turnOnLodaing();
                                          var user = await auth.signIn(
                                              email, password);
                                          auth.turnOffLodaing();
                                          var usermodel = await auth
                                              .getcurrentuserdata(user.uid);
                                          await Provider.of<LocationViewModel>(
                                                  context,
                                                  listen: false)
                                              .getCurrentPosition(context);

                                          await auth.setUser(usermodel);
                                          Navigator.pushNamed(
                                              context, MapScreen.id);
                                        } on FirebaseAuthException catch (e) {
                                          showTopSnackBar(
                                            context,
                                            CustomSnackBar.error(
                                              message: e.message.toString(),
                                            ),
                                          );
                                          auth.turnOffLodaing();
                                        }
                                      }
                                    }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.1),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        NoAccountText()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
