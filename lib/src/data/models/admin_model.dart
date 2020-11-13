import 'package:medicine_customer_app/src/data/models/_model.dart';

class Admin extends Model {
  String name;
  String phoneNumber;

  Admin({this.phoneNumber, this.name});

  Admin.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    phoneNumber = json['PhoneNumber'];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'PhoneNumber': phoneNumber,
    };
  }
}
