import 'package:final_project2/Screens/account_info_screen.dart';
import 'package:final_project2/Screens/help_screen.dart';
import 'package:final_project2/Screens/notification_screen.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/auth_view_model.dart';
import 'package:final_project2/widgets/bottom_nav_bar.dart';
import 'package:final_project2/widgets/custom_button.dart';
import 'package:final_project2/widgets/profile_pic.dart';
import 'package:final_project2/widgets/profile_tasktile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static String id = "ProfileScreen";
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthViewModel>(context).getUser();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              ProfilePic(),
              SizedBox(height: getProportionateScreenHeight(30)),
              ProfileMenu(
                text: "My Account",
                icon: "assets/icons/User Icon.svg",
                press: () => {Navigator.pushNamed(context, AccountInfo.id)},
              ),
              ProfileMenu(
                text: "Notifications",
                icon: "assets/icons/Bell.svg",
                press: () {
                  Navigator.pushNamed(context, NotificationScreen.id);
                },
              ),
              ProfileMenu(
                text: "Help Center",
                icon: "assets/icons/Question mark.svg",
                press: () {
                  Navigator.pushNamed(context, HelpScreen.id);
                },
              ),
              ProfileMenu(
                text: "Log Out",
                icon: "assets/icons/Log out.svg",
                press: () async {
                  showAlertDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: Text("Alert!"),
    content: Text(" Are you sure you want to logout? "),
    actions: [
      CustomButton(
        text: "Yes",
        onpressed: () async {
          await Provider.of<AuthViewModel>(context, listen: false).signOut();
          SystemNavigator.pop();
        },
        radius: getProportionateScreenWidth(10),
      ),
      CustomButton(
        text: "No",
        radius: getProportionateScreenWidth(10),
        onpressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
    barrierDismissible: true,
  );
}
