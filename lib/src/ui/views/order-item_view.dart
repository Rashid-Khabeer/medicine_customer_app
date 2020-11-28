import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_customer_app/src/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_customer_app/src/services/chat_service.dart';

class OrderItemView extends InkWell {
  OrderItemView({
    String day,
    String month,
    String title,
    String price,
    String status,
    Color color,
    String orderStatus,
    Function onTap,
    bool isComplete,
    String sentBy,
    String orderChatId,
  }) : super(
          onTap: onTap,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(day, style: k20BoldTextStyle),
                          Text(month, style: k20BoldTextStyle),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                              width: 1.0, height: 45.0, color: Colors.grey)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: k18BlackTextStyle),
                            SizedBox(height: 5.0),
                            Text(price, style: k18BlackTextStyle),
                          ],
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: ChatService(orderChatId: orderChatId)
                            .fetchUnRead(sentBy),
                        builder: (context, unRead) {
                          int _size = unRead.data?.size ?? -1;
                          if (_size > 0) {
                            return Stack(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 10.0, top: 10.0),
                                  child: Icon(
                                    CupertinoIcons.conversation_bubble,
                                    size: 30.0,
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 5,
                                  child: Container(
                                    padding: EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 14,
                                      minHeight: 14,
                                    ),
                                    child: Text(
                                      '${unRead.data.size}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10.0),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
                  child: Container(height: 1.0, color: Colors.grey),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 15.0, right: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!isComplete)
                        Text(orderStatus, style: k18BlackTextStyle),
                      Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Text(status, style: k18WhiteTextStyle),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
}
