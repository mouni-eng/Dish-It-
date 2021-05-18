import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/profile_view_model.dart';
import 'package:final_project2/widgets/bottom_nav_bar.dart';
import 'package:final_project2/widgets/profile_pic.dart';
import 'package:final_project2/widgets/profile_tasktile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project2/screens/control_view_screen.dart';

class ProfileScreen extends StatelessWidget {
  static String id = "ProfileScreen";
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, profile, child) => Scaffold(
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
                  press: () => {},
                ),
                ProfileMenu(
                  text: "Notifications",
                  icon: "assets/icons/Bell.svg",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Settings",
                  icon: "assets/icons/Settings.svg",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Help Center",
                  icon: "assets/icons/Question mark.svg",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Log Out",
                  icon: "assets/icons/Log out.svg",
                  press: () {
                    profile.signOut();
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, ControlView.id, (route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
