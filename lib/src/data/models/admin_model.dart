import 'package:medicine_customer_app/src/data/models/_model.dart';

class Admin extends Model {
  String name;
  String phoneNumber;
  String token;

  Admin({this.phoneNumber, this.name, this.token});

  Admin.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    phoneNumber = json['PhoneNumber'];
    token = json['token'];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'PhoneNumber': phoneNumber,
      'token': token,
    };
  }
}
