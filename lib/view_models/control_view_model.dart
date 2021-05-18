import 'package:final_project2/Screens/cart_screen.dart';
import 'package:final_project2/Screens/orders_screen.dart';
import 'package:final_project2/Screens/favorite_screen.dart';
import 'package:final_project2/Screens/home_screen.dart';
import 'package:final_project2/Screens/profile_screen.dart';
import 'package:flutter/material.dart';

class ControlViewModel extends ChangeNotifier {
  int _navigatorValue = 0;

  get navigatorValue => _navigatorValue;

  Widget currentScreen = HomeScreen();

  void changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    switch (selectedValue) {
      case 0:
        {
          currentScreen = HomeScreen();
          break;
        }
      case 1:
        {
          currentScreen = FavoriteScreen();
          break;
        }
      case 2:
        {
          currentScreen = ChatScreen();
          break;
        }
      case 3:
        {
          currentScreen = ProfileScreen();
        }
    }
    notifyListeners();
  }
}
