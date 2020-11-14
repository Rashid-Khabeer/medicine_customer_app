import 'package:medicine_customer_app/src/constants.dart';
import 'package:medicine_customer_app/src/ui/widgets/chat_bubble-widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rider',
          style: kAppBarStyle,
        ),
      ),
      body: Column(
        children: [
          Expanded(child: Container()),
          Align(
            alignment: Alignment.centerRight,
            child: ChatBubbleWidget(
              isMe: true,
              isSeen: true,
              message: 'Hello',
              time: '9:30 AM',
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ChatBubbleWidget(
              isMe: false,
              isSeen: true,
              message: 'This is a dummy chat design',
              time: '9:31 AM',
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ChatBubbleWidget(
              isMe: true,
              isSeen: false,
              message: 'OK',
              time: '9:32 AM',
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
                        padding: EdgeInsets.all(15.0),
                        maxLines: null, placeholder: 'Type a message...',
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        // decoration: InputDecoration(
                        //   contentPadding: EdgeInsets.only(
                        //       top: 13.0, bottom: 13.0, left: 20),
                        //   hintText: 'Type a message...',
                        //   hintStyle: TextStyle(color: Colors.black54),
                        //   enabledBorder: OutlineInputBorder(
                        //     borderSide: BorderSide(
                        //         color: Colors.transparent, width: 5.0),
                        //   ),
                        //   focusedBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(50),
                        //       borderSide:
                        //           BorderSide(color: Colors.green.shade100)),
                        // ),
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
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
