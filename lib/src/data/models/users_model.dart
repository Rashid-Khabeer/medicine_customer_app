import 'package:medicine_customer_app/src/data/models/_model.dart';

class UserModel extends Model {
  String name;
  String phoneNumber;

  UserModel({this.name, this.phoneNumber});

  UserModel.fromJson(Map<String, dynamic> json) {
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
