import 'package:medicine_customer_app/src/data/models/_model.dart';

class DeliveryBoy extends Model {
  String userName;
  String phoneNumber;
  String status;
  String token;

  DeliveryBoy({this.phoneNumber, this.status, this.userName, this.token});

  DeliveryBoy.fromJson(Map<String, dynamic> json) {
    userName = json['UserName'];
    phoneNumber = json['PhoneNumber'];
    status = json['Status'];
    token = json['Token'];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'UserName': userName,
      'PhoneNumber': phoneNumber,
      'Status': status,
      'Token': token,
    };
  }
}
