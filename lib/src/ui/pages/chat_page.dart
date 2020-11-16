import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_customer_app/src/constants.dart';
import 'package:medicine_customer_app/src/data/app_data.dart';
import 'package:medicine_customer_app/src/data/models/chat_model.dart';
import 'package:medicine_customer_app/src/services/chat_service.dart';
import 'package:medicine_customer_app/src/ui/widgets/chat_bubble-widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_customer_app/src/ui/widgets/simple-stream-builder_widget.dart';

class ChatPage extends StatelessWidget {
  final orderChatId;

  ChatPage({this.orderChatId});

  final TextEditingController _textController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Rider',
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
          Container(
            padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 12.0, left: 8, right: 8),
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(50),
                      child: CupertinoTextField(
                        controller: _textController,
                        padding: EdgeInsets.all(15.0),
                        maxLines: null,
                        placeholder: 'Type a message...',
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 45,
                  height: 45,
                  margin: EdgeInsets.only(right: 10, bottom: 13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: kMainColor,
                  ),
                  child: IconButton(
                    padding:
                        EdgeInsets.only(left: 4, right: 11, top: 0, bottom: 13),
                    alignment: Alignment.bottomRight,
                    iconSize: 20,
                    icon: Icon(
                      Icons.send_outlined,
                      color: Colors.white,
                    ),
                    onPressed: _sendAction,
                  ),
                ),
              ],
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
      _textController.text = '';
    } else {
      print('Empty String');
    }
  }
}
