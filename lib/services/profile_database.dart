import 'dart:convert';

import 'package:final_project2/Models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDatabase {
  setUser(UserModel user) async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setString("user", json.encode(user.toJson()));
  }

  Future<UserModel> get getUser async {
    UserModel userModel = await _getUser();
    return userModel;
  }

  _getUser() async {
    var preferences = await SharedPreferences.getInstance();
    var getuser = preferences.getString("user");
    return UserModel.fromjson(jsonDecode(getuser));
  }

  void deleteUser() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
