import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  double latitude;
  double longitude;
  Placemark place;

  Future<void> getCurrentLocation() async {
    try {
      Position _position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      latitude = _position.latitude;
      longitude = _position.longitude;
      List<Placemark> _p = await GeocodingPlatform.instance
          .placemarkFromCoordinates(latitude, longitude);
      place = _p[0];
    } catch (e) {
      print(e);
    }
  }
}
