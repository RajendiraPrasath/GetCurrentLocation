import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

sealed class Utility {
  static final formKey = GlobalKey<FormState>();
  static bool distanceCalculatedButtonEnabled = true;
  static bool startTrackingButtonEnabled = false;
  static bool stopTrackingButtonEnabled = false;
  static String totalDistance = "";
  static String distanceTravelled = "";
  static Timer? timer;
  static Map<String, dynamic> latLngList = <String, dynamic>{};

  static TextEditingController startingLatitudeController =
      TextEditingController(text: "12.274291");
  static TextEditingController startingLongitudeController =
      TextEditingController(text: "79.199262");
  static TextEditingController endingLatitudeController =
      TextEditingController(text: "12.246975");
  static TextEditingController endingLongitudeController =
      TextEditingController(text: "79.224825");

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static Future<void> getCurrentLocationLatLng() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            Exception('Location permissions are permanently denied.'));
      }

      if (permission == LocationPermission.denied) {
        return Future.error(Exception('Location permissions are denied.'));
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.high);
    Map<dynamic, dynamic> latLng = {
      "latitude": position.latitude,
      "longitude": position.longitude
    };
    Map<String, dynamic> dateTimeWithLatLng = <String, dynamic>{
      DateTime.now().millisecondsSinceEpoch.toString(): latLng
    };
    latLngList.addAll(dateTimeWithLatLng);
  }

  static double calculateTravelledDistance() {
    double totalDistance = 0;
    for (var i = 0; i < latLngList.length - 1; i++) {
      totalDistance += calculateDistance(
          latLngList.values.elementAt(i)["latitude"],
          latLngList.values.elementAt(i)["longitude"],
          latLngList.values.elementAt(i + 1)["latitude"],
          latLngList.values.elementAt(i + 1)["longitude"]);
    }
    return totalDistance;
  }

  static Future<void> startTracking() async {
    timer ??= Timer.periodic(const Duration(seconds: 5), (Timer t) async {
      await getCurrentLocationLatLng();
    });
  }

  static void stopTracking() {
    timer?.cancel();
    timer = null;
  }
}
