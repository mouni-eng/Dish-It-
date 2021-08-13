import 'package:final_project2/Models/address_model.dart';
import 'package:final_project2/Models/user_model.dart';
import 'package:final_project2/Screens/map_screen.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/auth_view_model.dart';
import 'package:final_project2/view_models/loacation_view_model.dart';
import 'package:final_project2/widgets/custom_button.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:final_project2/widgets/custom_textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddressScreen extends StatelessWidget {
  static String id = "addressScreen";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String userid, email, firstname, lastname, phoneNumber;
  AddressScreen(
      {this.firstname,
      this.lastname,
      this.email,
      this.userid,
      this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    String street, buildingnumb, floornumb, appartmentnumb;
    return Consumer<AuthViewModel>(
      builder: (context, auth, child) => ModalProgressHUD(
        inAsyncCall: Provider.of<LocationViewModel>(context).loading,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Address"),
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
                              labelText: "Street",
                              hintText: "Enter your Street",
                              image: "assets/icons/User.svg",
                              onsaved: (value) {
                                street = value;
                              },
                              onchanged: (value) {
                                street = value;
                              },
                              validate: (value) {
                                if (value.isEmpty) {
                                  return auth.validatetext("Enter your Street");
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            CustomTextFormField(
                              obscure: false,
                              labelText: "Building No.",
                              hintText: "Enter your Building No.",
                              image: "assets/icons/User.svg",
                              onsaved: (value) {
                                buildingnumb = value;
                              },
                              onchanged: (value) {
                                buildingnumb = value;
                              },
                              validate: (value) {
                                if (value.isEmpty) {
                                  return auth
                                      .validatetext("Enter your Building No.");
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            CustomTextFormField(
                              obscure: false,
                              labelText: "Floor no.",
                              hintText: "Enter your Floor no.",
                              image: "assets/icons/Phone.svg",
                              onsaved: (value) {
                                floornumb = value;
                              },
                              onchanged: (value) {
                                floornumb = value;
                              },
                              validate: (value) {
                                if (value.isEmpty) {
                                  return auth
                                      .validatetext("Enter your Floor no.");
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            CustomTextFormField(
                              obscure: false,
                              labelText: "Appartment No.",
                              hintText: "Enter your Appartment No.",
                              image: "assets/icons/Location point.svg",
                              onsaved: (value) {
                                appartmentnumb = value;
                              },
                              onchanged: (value) {
                                appartmentnumb = value;
                              },
                              validate: (value) {
                                if (value.isEmpty) {
                                  return auth.validatetext(
                                      "Enter your Appartment No.");
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
                                          await Provider.of<LocationViewModel>(
                                                  context,
                                                  listen: false)
                                              .determinePosition(context);
                                          await auth.saveUser(
                                            userid,
                                            firstname,
                                            lastname,
                                            phoneNumber,
                                            email,
                                            AddressModel(
                                                    street: street,
                                                    buildingnumber:
                                                        buildingnumb,
                                                    floornumber: floornumb,
                                                    appartmentnumber:
                                                        appartmentnumb,
                                                    phonenumber: phoneNumber)
                                                .toJson(),
                                            Provider.of<LocationViewModel>(
                                                    context,
                                                    listen: false)
                                                .latitude,
                                            Provider.of<LocationViewModel>(
                                                    context,
                                                    listen: false)
                                                .longitude,
                                          );
                                          await auth.setUser(UserModel(
                                            name: firstname,
                                            lastName: lastname,
                                            userId: userid,
                                            email: email,
                                            address: AddressModel(
                                                street: street,
                                                buildingnumber: buildingnumb,
                                                floornumber: floornumb,
                                                appartmentnumber:
                                                    appartmentnumb,
                                                phonenumber: phoneNumber),
                                            latitude:
                                                Provider.of<LocationViewModel>(
                                                        context,
                                                        listen: false)
                                                    .latitude,
                                            longitude:
                                                Provider.of<LocationViewModel>(
                                                        context,
                                                        listen: false)
                                                    .longitude,
                                          ));

                                          Navigator.pushNamed(
                                              context, MapScreen.id);
                                        } on FirebaseAuthException catch (e) {
                                          showTopSnackBar(
                                            context,
                                            CustomSnackBar.error(
                                              message: e.message.toString(),
                                            ),
                                          );
                                        }
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
      ),
    );
  }
}
