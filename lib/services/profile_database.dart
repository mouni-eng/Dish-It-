import 'dart:convert';
import 'dart:io';

import 'package:final_project2/Models/user_model.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<void> deleteUser() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    await preferences.remove("user");
  }

  Future<void> setAddress(String addressLine) async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setString("addressLine", addressLine);
  }

  getAddress() async {
    var preferences = await SharedPreferences.getInstance();
    var address = preferences.getString("addressLine");
    return address;
  }

  Future<File> pickImage() async {
    File imageFile = File(await ImagePicker().pickImage(source: ImageSource.gallery).then((pickedFile) => pickedFile.path));
    return imageFile;
  }
}
