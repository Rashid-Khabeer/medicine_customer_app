import 'package:medicine_customer_app/src/constants.dart';
import 'package:flutter/material.dart';

class ChatBubbleWidget extends StatelessWidget {
  final String message, time;
  final isMe, isSeen;

  ChatBubbleWidget({this.isMe, this.isSeen, this.message, this.time});

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMe ? kMainColor : Colors.grey.shade200;
    final msgTxtColor = isMe ? Colors.white : Colors.black;
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = isMe
        ? BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
            bottomLeft: Radius.circular(18.0),
            // bottomRight: Radius.circular(18.0),
          )
        : BorderRadius.only(
            topRight: Radius.circular(18.0),
            topLeft: Radius.circular(18.0),
            // bottomLeft: Radius.circular(18.0),
            bottomRight: Radius.circular(18.0),
          );
    final Color seenColor = isSeen ? Colors.green : Colors.white;
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: .5,
                spreadRadius: 1.0,
                color: Colors.black.withOpacity(.12),
              ),
            ],
            color: bubbleColor,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 68.0),
                child: Text(
                  message,
                  style: TextStyle(color: msgTxtColor, fontSize: 15.0),
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text(
                      time,
                      style: TextStyle(
                        color: msgTxtColor,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(width: 3.0),
                    if (isMe)
                      Icon(
                        Icons.done_all,
                        size: 13.0,
                        color: seenColor,
                      )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
