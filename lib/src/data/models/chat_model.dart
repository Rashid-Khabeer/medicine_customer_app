import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_customer_app/src/data/models/_model.dart';

class Chat extends Model {
  String sentBy;
  bool isReadByUser;
  bool isReadByRider;
  String text;
  Timestamp timestamp;

  Chat({
    this.timestamp,
    this.text,
    this.isReadByUser,
    this.isReadByRider,
    this.sentBy,
  });

  Chat.fromJson(Map<String, dynamic> json) {
    sentBy = json['sentBy'];
    text = json['text'];
    isReadByRider = json['isReadByRider'];
    isReadByUser = json['isReadyByUser'];
    timestamp = json['timestamp'];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'sentBy': sentBy,
      'isReadByRider': isReadByRider,
      'isReadyByUser': isReadByUser,
      'text': text,
      'timestamp': timestamp,
    };
  }
}
