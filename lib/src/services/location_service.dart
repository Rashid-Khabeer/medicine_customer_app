// import 'package:location/location.dart';

class CurrentLocation {
  double latitude;
  double longitude;
  //
  // bool _serviceEnabled;
  // PermissionStatus _permissionGranted;
  // LocationData _locationData;
  // LocationAccuracy _locationAccuracy;
  //
  // Future<void> getCurrentLocation() async {
  //   _locationAccuracy = LocationAccuracy.high;
  //   try {
  //     Location location = Location();
  //     _serviceEnabled = await location.serviceEnabled();
  //     if (!_serviceEnabled) {
  //       _serviceEnabled = await location.requestService();
  //       if (!_serviceEnabled) return;
  //     }
  //     _permissionGranted = await location.hasPermission();
  //     if (_permissionGranted == PermissionStatus.denied) {
  //       _permissionGranted = await location.requestPermission();
  //       if (_permissionGranted != PermissionStatus.granted) return;
  //     }
  //     // location.a
  //     _locationData = await location.getLocation();
  //     latitude = _locationData.latitude;
  //     longitude = _locationData.longitude;
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
