import 'package:final_project2/services/profile_database.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LocationViewModel extends ChangeNotifier {
  double latitude;
  double longitude;
  LatLng currentLocation;
  GoogleMapController mapController;
  var selectedAdress;
  String addressLine;
  bool loading = false;
  bool locating = false;

  LocationViewModel() {
    getAddress();
  }

  Future<void> getCurrentPosition(BuildContext context) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      loading = true;
      latitude = position.latitude;
      longitude = position.longitude;
      final coordinates = new Coordinates(latitude, longitude);
      final addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      selectedAdress = addresses.first;
      currentLocation = LatLng(latitude, longitude);
      notifyListeners();
      loading = false;
    } else {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "Permission not allowed",
        ),
      );
    }
  }

  // ignore: missing_return
  Future<Position> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    await getCurrentPosition(context);
  }

  void onCameraMove(CameraPosition cameraPosition) async {
    locating = true;
    latitude = cameraPosition.target.latitude;
    longitude = cameraPosition.target.longitude;
    notifyListeners();
  }

  void onCreated(GoogleMapController controller) {
    mapController = controller;
    notifyListeners();
  }

  Future<void> getMoveCamer() async {
    final coordinates = new Coordinates(latitude, longitude);
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    selectedAdress = addresses.first;
    print("${selectedAdress.featureName} : ${selectedAdress.addressLine}");
    locating = false;
    notifyListeners();
  }

  getAddress() async {
    await ProfileDatabase().getAddress().then((value) {
      addressLine = value;
    });
    notifyListeners();
  }

  Future<void> setAddress(String address) async {
    await ProfileDatabase().setAddress(address);
  }
}
