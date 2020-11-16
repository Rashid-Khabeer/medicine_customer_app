import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_customer_app/src/data/models/order-chat_model.dart';
import 'package:medicine_customer_app/src/services/firebase-firestore_service.dart';

class OrderChatService extends MedicineService<OrderChat> {
  @override
  String get collectionName => 'OrderChats';

  @override
  OrderChat parseModel(DocumentSnapshot document) {
    return OrderChat.fromJson(document.data())..id = document.id;
  }
}
