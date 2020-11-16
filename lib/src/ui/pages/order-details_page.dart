import 'package:medicine_customer_app/src/constants.dart';
import 'package:medicine_customer_app/src/data/models/orders_model.dart';
import 'package:medicine_customer_app/src/services/order_service.dart';
import 'package:medicine_customer_app/src/ui/modals/dialogs.dart';
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
  Orders _order;

  String _sellerNote(Orders order) {
    if (order.isComplete)
      return 'Order is Completed';
    else {
      if (order.adminBillStatus) {
        if (order.userConfirmStatus)
          return 'Your order is ready to ship';
        else
          return 'Please Confirm your purchase';
      } else
        return 'Your order is submitted!';
    }
  }

  bool _buttonsAction(Orders order) {
    if (order.adminBillStatus) {
      if (order.userConfirmStatus)
        return false;
      else
        return true;
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
              if (order.orderStatus == 'InComplete')
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
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 20.0),
                                child: Text('Seller Note:',
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
                      if (order?.adminAssignedBoy ?? false)
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(CupertinoIcons.chat_bubble),
                              Text('For special instruction: '),
                              GestureDetector(
                                onTap: () => navigateTo(context, ChatPage()),
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
                            if (order.imagesUrl.isNotEmpty)
                              AttachedImagesView(imagesUrl: order.imagesUrl),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              else if (order.orderStatus == 'UserCancelled')
                return Center(
                  child: Text('You cancelled this order'),
                );
              else if (order.orderStatus == 'AdminCancelled')
                return Center(
                  child: Text(
                    'Admin cancelled this order due to: ${order?.cancelledNote ?? ''}',
                  ),
                );
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
    Navigator.of(context).pop();
    InfoDialog(context: context, content: 'Your order is ready to ship').show();
  }

  _cancelAction() {
    ConfirmDialog(
      context: context,
      content: 'Do you want to cancel this order',
      function: () async {
        _order.orderStatus = 'UserCancelled';
        WaitingDialog(context: context).show();
        await OrderService().updateFirestore(_order);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    ).show();
  }
}
