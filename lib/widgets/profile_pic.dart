import 'dart:io' as io;
import 'package:final_project2/services/profile_database.dart';
import 'package:final_project2/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfilePic extends StatefulWidget {
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  io.File _image;
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthViewModel>(context).getProfilePic();
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
              backgroundImage:
                  Provider.of<AuthViewModel>(context).profilePicture == null
                      ? AssetImage("assets/images/Profile Image.png")
                      : NetworkImage(
                          Provider.of<AuthViewModel>(context, listen: false)
                              .profilePicture)),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
                color: Color(0xFFF5F6F9),
                onPressed: () async {
                  var image = await ProfileDatabase().pickImage();
                  setState(() {
                    _image = image;
                  });
                  Provider.of<AuthViewModel>(context, listen: false)
                      .updateUserPic(image);
                  Provider.of<AuthViewModel>(context, listen: false)
                      .getProfilePic();
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
