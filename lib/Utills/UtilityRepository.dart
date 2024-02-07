import 'Utility.dart';

class TrackRepository {
  String getTotalDistance() {
    Utility.distanceCalculatedButtonEnabled = false;
    Utility.totalDistance =
        "Total Distance : ${Utility.calculateDistance(double.parse(Utility.startingLatitudeController.text), double.parse(Utility.startingLongitudeController.text), double.parse(Utility.endingLatitudeController.text), double.parse(Utility.endingLongitudeController.text)).toStringAsFixed(3)} KM";
    return Utility.totalDistance;
  }

  void startTracking() {
    Utility.startTracking();
  }

  void stopTracking() {
    Utility.stopTracking();
  }

  String getDistanceTravelled() {
    return "distanceTravelled : ${Utility.calculateTravelledDistance().toStringAsFixed(3)} KM";
  }
}
