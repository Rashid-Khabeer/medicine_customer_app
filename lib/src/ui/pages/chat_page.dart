import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_customer_app/src/constants.dart';
import 'package:medicine_customer_app/src/data/app_data.dart';
import 'package:medicine_customer_app/src/data/models/chat_model.dart';
import 'package:medicine_customer_app/src/services/chat_service.dart';
import 'package:medicine_customer_app/src/services/fcm-message_service.dart';
import 'package:medicine_customer_app/src/ui/widgets/chat_bubble-widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_customer_app/src/ui/widgets/simple-stream-builder_widget.dart';

class ChatPage extends StatelessWidget {
  final orderChatId;
  final token;
  final name;

  ChatPage({this.orderChatId, this.token, this.name});

  final TextEditingController _textController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          '$name',
          style: kAppBarStyle,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SimpleStreamBuilder.simpler(
              stream: ChatService(orderChatId: orderChatId)
                  .fetchAllSortedFirestore(),
              context: context,
              builder: (List<Chat> list) {
                return ListView.builder(
                  reverse: true,
                  itemCount: list.length,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    Chat chat = list.elementAt(index);
                    chat.isReadByUser = true;
                    ChatService(orderChatId: orderChatId).updateFirestore(chat);
                    return ChatBubbleWidget(
                      message: chat.text,
                      isSeen: chat.isReadByRider,
                      isMe: AppData.uId == chat.sentBy ? true : false,
                      time: ((DateTime date) =>
                              "${(date.hour % 12) == 0 ? 12 : date.hour % 12}:${date.minute} ${date.hour >= 12 ? 'PM' : 'AM'}")(
                          chat.timestamp.toDate()),
                    );
                  },
                );
              },
            ),
          ),
          TextField(
            style: TextStyle(fontSize: 18),
            controller: _textController,
            decoration: InputDecoration(
              // border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              hintText: 'Type a Message',
              suffixIcon: IconButton(
                icon: Icon(Icons.send_outlined),
                onPressed: _sendAction,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _sendAction() async {
    if (_textController.text.isNotEmpty) {
      Chat _chat = Chat(
        sentBy: AppData.uId,
        timestamp: Timestamp.now(),
        isReadByUser: true,
        isReadByRider: false,
        text: _textController.text,
      );
      await ChatService(orderChatId: orderChatId).insertFirestore(_chat);
      await FcmMessageService.sendFcmMessage(
        message: _chat.text,
        title: 'New Message',
        token: token,
      );
      _textController.text = '';
    }
  }
}
