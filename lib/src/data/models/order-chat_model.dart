import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_customer_app/src/data/models/_model.dart';

class OrderChat extends Model {
  String userId;
  String riderId;
  Timestamp timestamp;

  OrderChat({this.timestamp, this.riderId, this.userId});

  OrderChat.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    riderId = json['riderId'];
    timestamp = json['timestamp'];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'riderId': riderId,
      'timestamp': timestamp,
    };
  }
}
