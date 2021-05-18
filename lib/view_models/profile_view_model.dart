import 'package:final_project2/Models/user_model.dart';
import 'package:final_project2/services/profile_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileDatabase _profileDatabase = ProfileDatabase();
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FacebookLogin _facebookLogin = FacebookLogin();

  bool loading = false;

  ProfileViewModel() {
    getUser();
  }

  UserModel _userModel;
  UserModel get userModel {
    return _userModel;
  }

  getUser() async {
    loading = true;
    await _profileDatabase.getUser.then((value) {
      _userModel = value;
      print(_userModel);
    loading = false;
    });
    notifyListeners();
  }
  
  void signOut() {
    _googleSignIn.signOut();
    _auth.signOut();
    _facebookLogin.logOut();
    _profileDatabase.deleteUser();
  }
}