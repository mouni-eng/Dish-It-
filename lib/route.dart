import 'package:final_project2/Screens/account_info_screen.dart';
import 'package:final_project2/Screens/address_screen.dart';
import 'package:final_project2/Screens/allproducts_screen.dart';
import 'package:final_project2/Screens/cart_screen.dart';
import 'package:final_project2/Screens/checkout_screen.dart';
import 'package:final_project2/Screens/complete_profile.dart';
import 'package:final_project2/Screens/control_view_screen.dart';
import 'package:final_project2/Screens/details_screen.dart';
import 'package:final_project2/Screens/forget_password_screen.dart';
import 'package:final_project2/Screens/help_screen.dart';
import 'package:final_project2/Screens/home_screen.dart';
import 'package:final_project2/Screens/loginsucces_screen.dart';
import 'package:final_project2/Screens/map_screen.dart';
import 'package:final_project2/Screens/notification_screen.dart';
import 'package:final_project2/Screens/order_success_screen.dart';
import 'package:final_project2/Screens/orders_screen.dart';
import 'package:final_project2/Screens/products_screen.dart';
import 'package:final_project2/Screens/profile_screen.dart';
import 'package:final_project2/Screens/search_screen.dart';
import 'package:final_project2/Screens/sign_in_screen.dart';
import 'package:final_project2/Screens/sign_up_screen.dart';
import 'package:final_project2/Screens/specific_category_screen.dart';
import 'package:final_project2/Screens/splash_screen.dart';
import 'package:final_project2/services/help_center_service.dart';
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
  AddressScreen.id: (context) => AddressScreen(),
  ProductsScreen.id: (context) => ProductsScreen(),
  AllProductsScreen.id: (context) => AllProductsScreen(),
  OrderScreen.id: (context) => OrderScreen(),
  SpecificCategory.id: (context) => SpecificCategory(),
  SearchScreen.id: (context) => SearchScreen(),
  MapScreen.id: (context) => MapScreen(),
  AccountInfo.id: (context) => AccountInfo(),
  NotificationScreen.id: (context) => NotificationScreen(),
  HelpScreen.id: (context) => HelpScreen(),
};
