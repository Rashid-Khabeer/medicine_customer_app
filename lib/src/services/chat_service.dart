import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicine_customer_app/src/data/models/chat_model.dart';
import 'package:medicine_customer_app/src/services/firebase-firestore_service.dart';

class ChatService extends MedicineService<Chat> {
  String orderChatId;

  ChatService({@required this.orderChatId});

  @override
  String get collectionName => 'OrderChats/$orderChatId/Chats';

  @override
  Chat parseModel(DocumentSnapshot document) {
    return Chat.fromJson(document.data())..id = document.id;
  }
}
