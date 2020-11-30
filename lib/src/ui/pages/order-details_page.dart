import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_customer_app/src/constants.dart';
import 'package:medicine_customer_app/src/data/app_data.dart';
import 'package:medicine_customer_app/src/data/models/admin_model.dart';
import 'package:medicine_customer_app/src/data/models/chat_model.dart';
import 'package:medicine_customer_app/src/data/models/delivery-boy_model.dart';
import 'package:medicine_customer_app/src/data/models/order-chat_model.dart';
import 'package:medicine_customer_app/src/data/models/orders_model.dart';
import 'package:medicine_customer_app/src/services/admin_service.dart';
import 'package:medicine_customer_app/src/services/chat_service.dart';
import 'package:medicine_customer_app/src/services/delivery-boy_service.dart';
import 'package:medicine_customer_app/src/services/fcm-message_service.dart';
import 'package:medicine_customer_app/src/services/order-chat_service.dart';
import 'package:medicine_customer_app/src/services/order_service.dart';
import 'package:medicine_customer_app/src/ui/modals/dialogs.dart';
import 'package:medicine_customer_app/src/ui/modals/snackbar.dart';
import 'package:medicine_customer_app/src/ui/pages/chat_page.dart';
import 'package:medicine_customer_app/src/ui/views/attached-images_view.dart';
import 'package:medicine_customer_app/src/ui/widgets/button_widget.dart';
import 'package:medicine_customer_app/src/ui/widgets/simple-stream-builder_widget.dart';
import 'package:medicine_customer_app/src/utility/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatefulWidget {
  final String orderId;

  OrderDetailsPage({this.orderId});

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Orders _order;
  String cancelNote;

  String _sellerNote(Orders order) {
    if (order.isComplete)
      return 'Order is Completed';
    else {
      if (order.cancelledBy?.isEmpty ?? true) {
        if (order.adminBillStatus) {
          if (order.userConfirmStatus)
            return 'Your order is ready to ship';
          else
            return 'Please Confirm your purchase';
        } else
          return 'Your order is submitted!';
      } else
        return '${order.orderStatus} due to ${order.cancelledNote}';
    }
  }

  bool _buttonsAction(Orders order) {
    if (order.adminBillStatus) {
      if (order.cancelledBy?.isEmpty ?? true) {
        if (order.userConfirmStatus)
          return false;
        else
          return true;
      } else
        return false;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Detail',
          style: kAppBarStyle,
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: SimpleStreamBuilder.simpler(
            stream: OrderService().fetchSingleOrder(widget.orderId),
            context: context,
            builder: (Orders order) {
              _order = order;
              // if (order.orderStatus == 'InComplete')
              return Card(
                child: Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 20.0),
                      child: Text(
                        order.orderCategory,
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(Icons.motorcycle_sharp,
                              color: kMainColor, size: 50.0),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text('Price',
                                          style: k18BlackTextStyle),
                                    ),
                                    Text('${order?.price ?? ''} Rs',
                                        style: k18BlackTextStyle),
                                  ],
                                ),
                                SizedBox(height: 25.0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text('Shipping Charges',
                                          style: k18BlackTextStyle),
                                    ),
                                    Text('${order?.shippingPrice ?? ''} Rs',
                                        style: k18BlackTextStyle),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 23.0, bottom: 5.0),
                                  child: Container(
                                      height: 1.0, color: Colors.grey),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text('Total',
                                          style: k18BlackTextStyle),
                                    ),
                                    Text('${order?.total ?? ''} Rs',
                                        style: k18BlackTextStyle),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        color: kSecondaryColor,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 20.0),
                              child: Text('Status:',
                                  style: k16TextStyle.copyWith(
                                      fontWeight: FontWeight.bold)),
                            ),
                            Expanded(
                              child: Text(
                                _sellerNote(order),
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_buttonsAction(order))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonWidget(
                            height: 40.0,
                            text: 'Confirm',
                            onPressed: _confirmAction,
                          ),
                          SizedBox(width: 5.0),
                          ButtonWidget(
                            height: 40.0,
                            onPressed: _cancelAction,
                            text: 'Cancel',
                            color: Colors.red,
                          ),
                        ],
                      ),
                    if (!order.isComplete)
                      if (order?.adminAssignedBoy ?? false)
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream:
                                    ChatService(orderChatId: order.orderChatId)
                                        .fetchUnRead(order.deliveryBoyId),
                                builder: (context, unRead) {
                                  int _size = unRead.data?.size ?? -1;
                                  if (_size > 0) {
                                    return Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 5.0, top: 5.0),
                                          child: Icon(CupertinoIcons
                                              .conversation_bubble),
                                        ),
                                        Positioned(
                                          top: 1,
                                          right: 1,
                                          child: Container(
                                            padding: EdgeInsets.all(2.0),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                            ),
                                            constraints: BoxConstraints(
                                              minWidth: 14,
                                              minHeight: 14,
                                            ),
                                            child: Text(
                                              '${unRead.data.size}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Icon(CupertinoIcons.chat_bubble);
                                  }
                                },
                              ),
                              Text('For special instruction: '),
                              GestureDetector(
                                onTap: _chatAction,
                                child: Text(
                                  'Contact With Rider',
                                  style: k16TextStyle.copyWith(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Column(
                        children: [
                          if (order.note.isNotEmpty)
                            Row(
                              children: [
                                Text('Note: ', style: k18BlackTextStyle),
                                Text(
                                  order.note,
                                  style: k16TextStyle,
                                ),
                              ],
                            ),
                          SizedBox(height: 10.0),
                          if (order.imagesUrl.isNotEmpty)
                            AttachedImagesView(imagesUrl: order.imagesUrl),
                        ],
                      ),
                    ),
                  ],
                ),
              );
              // else if (order.orderStatus == 'UserCancelled')
              //   return Center(
              //     child: Text('You cancelled this order'),
              //   );
              // else if (order.orderStatus == 'AdminCancelled')
              //   return Center(
              //     child: Text(
              //       'Admin cancelled this order due to: ${order?.cancelledNote ?? ''}',
              //     ),
              //   );
            },
          ),
        ),
      ),
    );
  }

  _confirmAction() async {
    _order.userConfirmStatus = true;
    WaitingDialog(context: context).show();
    await OrderService().updateFirestore(_order);
    String adminToken = (await AdminService().fetchAdmin()).token;
    await FcmMessageService.sendFcmMessage(
      message:
          '${_order.address} confirmed the order of ${_order.total}, Assign Delivery Boy',
      title: 'Order Confirmed',
      token: adminToken,
    );
    Navigator.of(context).pop();
    InfoDialog(context: context, content: 'Your order is ready to ship').show();
  }

  _cancelAction() {
    CancelOrderDialog(
      context: context,
      function: _cancelOrder,
      onChange: (value) => cancelNote = value,
    ).show();
  }

  _cancelOrder() async {
    Navigator.of(context).pop();
    print(cancelNote);
    if (cancelNote?.isEmpty ?? true) {
      _scaffoldKey.currentState.showSnackBar(
        ShowSnackBar(
          icon: Icons.error,
          text: 'Please enter any reason',
        ),
      );
      return;
    }
    _order.orderStatus = 'UserCancelled';
    _order.cancelledBy = 'user';
    _order.cancelledNote = cancelNote;
    WaitingDialog(context: context).show();
    String adminToken = (await AdminService().fetchAdmin()).token;
    await FcmMessageService.sendFcmMessage(
      message:
          '${_order.address} cancelled the order due to ${_order.cancelledNote}',
      title: 'Order Cancelled',
      token: adminToken,
    );
    await OrderService().updateFirestore(_order);
    Navigator.of(context).pop();
  }

  _chatAction() async {
    String token;
    String name;
    if (_order.deliveredBy == 'admin') {
      Admin admin = await AdminService().fetchAdmin();
      token = admin.token;
      name = admin.name;
    } else {
      DeliveryBoy boy =
          await DeliveryBoyService().fetchOneFirestore(_order.deliveryBoyId);
      token = boy.token;
      name = boy.userName;
    }
    if (_order.orderChatId?.isNotEmpty ?? false)
      navigateTo(
        context,
        ChatPage(
          orderChatId: _order.orderChatId,
          token: token,
          name: name,
        ),
      );
    else {
      WaitingDialog(context: context).show();
      OrderChat _orderChat = OrderChat(
        timestamp: Timestamp.now(),
        userId: AppData.uId,
        riderId: _order.deliveryBoyId,
      );
      _orderChat = await OrderChatService().insertFirestore(_orderChat);
      _order.orderChatId = _orderChat.id;
      await OrderService().updateFirestore(_order);
      Chat _chat = Chat(
        timestamp: Timestamp.now(),
        text: 'I am moving forward towards you!!',
        isReadByRider: false,
        isReadByUser: false,
        sentBy: _order.deliveryBoyId,
      );
      await ChatService(orderChatId: _orderChat.id).insertFirestore(_chat);
      Navigator.of(context).pop();
      navigateTo(
        context,
        ChatPage(
          orderChatId: _order.orderChatId,
          token: token,
          name: name,
        ),
      );
    }
  }
}
