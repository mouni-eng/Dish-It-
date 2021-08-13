import 'package:final_project2/Screens/loginsucces_screen.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/auth_view_model.dart';
import 'package:final_project2/view_models/loacation_view_model.dart';
import 'package:final_project2/widgets/custom_button.dart';
import 'package:final_project2/widgets/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  static String id = "MapScreen";

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationViewModel>(
      builder: (context, map, child) => Scaffold(
          body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: map.currentLocation, zoom: 19.5),
            zoomControlsEnabled: false,
            minMaxZoomPreference: MinMaxZoomPreference(1.5, 20.8),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            mapToolbarEnabled: true,
            onCameraMove: (CameraPosition postion) {
              map.onCameraMove(postion);
            },
            onMapCreated: (GoogleMapController controller) {
              map.onCreated(controller);
            },
            onCameraIdle: () {
              map.getMoveCamer();
            },
          ),
          Center(
            child: SvgPicture.asset(
              "assets/icons/person.svg",
              color: Colors.black,
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              height: getProportionateScreenHeight(200),
              width: SizeConfig.screenWidth,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    map.locating
                        ? LinearProgressIndicator(
                            backgroundColor: Colors.transparent,
                            valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                          )
                        : Container(),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_searching,
                          color: kPrimaryColor,
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(8),
                        ),
                        CustomText(
                          text: map.locating
                              ? "Loading...."
                              : map.selectedAdress.featureName,
                          size: getProportionateScreenWidth(20),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    CustomText(
                      text: map.selectedAdress.addressLine,
                      aligment: TextAlign.center,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          onpressed: () async {
                            Provider.of<AuthViewModel>(context, listen: false)
                                .turnOffLodaing();
                            await Provider.of<AuthViewModel>(context,
                                    listen: false)
                                .getUser();
                            await Provider.of<AuthViewModel>(context,
                                    listen: false)
                                .updateUser(map.selectedAdress.addressLine);
                            await Provider.of<LocationViewModel>(context,
                                    listen: false)
                                .setAddress(map.selectedAdress.addressLine);
                            Navigator.pushNamed(context, LoginSuccesScreen.id);
                          },
                          text: "Confirm Location",
                          radius: 15,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
