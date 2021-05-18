import 'package:flutter/cupertino.dart';

class SplashViewModel extends ChangeNotifier {
  int currentPage = 0;

  void changeScreen(int index) {
    currentPage = index;
    notifyListeners();
  }

}
