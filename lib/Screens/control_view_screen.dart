import 'package:final_project2/Screens/home_screen.dart';
import 'package:final_project2/Screens/splash_screen.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/auth_view_model.dart';
import 'package:final_project2/view_models/control_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ControlView extends StatelessWidget {
  static String id = 'ControlView';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Provider.of<AuthViewModel>(context).getcurrentuser() == null
        ? SplashScreen()
        : Provider.of<ControlViewModel>(context).currentScreen;
  }
}
