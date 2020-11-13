import 'package:medicine_customer_app/src/data/models/_model.dart';

class UserModel extends Model {
  String name;
  String phoneNumber;
  String address;
  double lat;
  double lon;

  UserModel({this.name, this.address, this.lat, this.lon, this.phoneNumber});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    phoneNumber = json['PhoneNumber'];
    address = json['Address'];
    lat = json['Latitude'];
    lon = json['Longitude'];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Address': address,
      'Latitude': lat,
      'Longitude': lon,
    };
  }
}
