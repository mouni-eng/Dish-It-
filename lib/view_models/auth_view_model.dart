import 'package:final_project2/Models/user_model.dart';
import 'package:final_project2/services/database_helper.dart';
import 'package:final_project2/services/firebase_user.dart';
import 'package:final_project2/services/profile_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthViewModel extends ChangeNotifier {
  ProfileDatabase _profileDatabase = ProfileDatabase();
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FacebookLogin _facebookLogin = FacebookLogin();

  bool remember = false;
  String verficId;

  String validatetext(String text) {
    switch (text) {
      case 'Enter your Email':
        return 'Email is empty';
      case 'Enter your Name':
        return 'Name is empty';
      case 'Enter your Password':
        return 'password is empty';
      case 'Re-enter your password':
        return 'password does not match';
    }
  }

  UserModel userData;

  Future<User> signIn(String email, password) async {
    var credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return credential.user;
  }

  void checkBox(bool value) {
    remember = value;
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<User> signUp(String email, password) async {
    var credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return credential.user;
  }

  Future<String> getgoogleacc() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    await _auth.signInWithCredential(credential);
    return googleSignInAuthentication.idToken;
  }

  Future<String> getfacebook() async {
    FacebookLoginResult result = await _facebookLogin.logIn(['email']);

    final accesstoken = result.accessToken.token;

    if (result.status == FacebookLoginStatus.loggedIn) {
      final facebookcredential = FacebookAuthProvider.credential(accesstoken);

      await _auth.signInWithCredential(facebookcredential);
    }

    return result.accessToken.userId;
  }

  Future<void> saveUser(
      String userId, name, lastName, phoneNumber, address, email) async {
    var userModel = UserModel(
      userId: userId,
      email: email,
      name: name,
      lastName: lastName,
      phoneNumber: phoneNumber,
      address: address,
    );

    await FireBaseUser().adduser(userModel);
    setUser(userModel);
    notifyListeners();
  }

  User getcurrentuser() {
    final user = _auth.currentUser;
    return user;
  }

    void setUser(UserModel user) async {
    await _profileDatabase.setUser(user);
  }

  /*Future<void> otp(String phoneNumber, BuildContext context) async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential authCredential) {
      _auth.signInWithCredential(authCredential);
      Navigator.pushNamed(context, LoginSuccesScreen.id);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exepction) {
      print(exepction);
    };

    final PhoneCodeSent smsSent = (String verId, [int forcedResend]) {
      verficId = verId;
      notifyListeners();
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      verficId = verId;
      notifyListeners();
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }*/
}
