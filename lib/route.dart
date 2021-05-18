import 'package:final_project2/Screens/cart_screen.dart';
import 'package:final_project2/Screens/checkout_screen.dart';
import 'package:final_project2/Screens/complete_profile.dart';
import 'package:final_project2/Screens/control_view_screen.dart';
import 'package:final_project2/Screens/details_screen.dart';
import 'package:final_project2/Screens/forget_password_screen.dart';
import 'package:final_project2/Screens/home_screen.dart';
import 'package:final_project2/Screens/loginsucces_screen.dart';
import 'package:final_project2/Screens/order_success_screen.dart';
import 'package:final_project2/Screens/profile_screen.dart';
import 'package:final_project2/Screens/sign_in_screen.dart';
import 'package:final_project2/Screens/sign_up_screen.dart';
import 'package:final_project2/Screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.id: (context) => SplashScreen(),
  SignInScreen.id: (context) => SignInScreen(),
  LoginSuccesScreen.id: (context) => LoginSuccesScreen(),
  ForgetPassword.id: (context) => ForgetPassword(),
  SignUpScreen.id: (context) => SignUpScreen(),
  CompleteProfile.id: (context) => CompleteProfile(),
  HomeScreen.id: (context) => HomeScreen(),
  CartScreen.id: (context) => CartScreen(),
  DetailsScreen.id: (context) => DetailsScreen(),
  ControlView.id: (context) => ControlView(),
  ProfileScreen.id: (context) => ProfileScreen(),
  CheckoutScreen.id: (context) => CheckoutScreen(),
  OrderSuccess.id: (context) => OrderSuccess(),
};
