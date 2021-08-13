import 'package:final_project2/Screens/control_view_screen.dart';
import 'package:final_project2/Screens/home_screen.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/auth_view_model.dart';
import 'package:final_project2/widgets/custom_button.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginSuccesScreen extends StatelessWidget {
  static String id = "loginsucces";
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthViewModel>(context).loading = false;
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Success"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(18)),
        child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            Image.asset(
              "assets/images/success.png",
              height: SizeConfig.screenHeight * 0.4,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.08),
            CustomText(
              text: "Login Success",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              size: getProportionateScreenWidth(30),
            ),
            Spacer(flex: 3),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "Back to Home",
                onpressed: () {
                  Navigator.pushNamed(context, ControlView.id);
                },
                size: getProportionateScreenWidth(18),
                radius: 20,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
