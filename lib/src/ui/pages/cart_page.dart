import 'package:medicine_customer_app/src/constants.dart';
import 'package:medicine_customer_app/src/data/models/orders_model.dart';
import 'package:medicine_customer_app/src/services/order_service.dart';
import 'package:medicine_customer_app/src/ui/pages/order-details_page.dart';
import 'package:medicine_customer_app/src/ui/views/order-item_view.dart';
import 'package:medicine_customer_app/src/ui/widgets/simple-stream-builder_widget.dart';
import 'package:medicine_customer_app/src/utility/app_utils.dart';
import 'package:medicine_customer_app/src/utility/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String _statusCheck(Orders order) {
    if (order.adminBillStatus) {
      if (order.userConfirmStatus)
        return 'Confirmed';
      else
        return 'Pending';
    } else
      return 'Requested';
  }

  Color _colorCheck(String status) {
    if (status == 'Confirmed')
      return Colors.green;
    else if (status == 'Requested')
      return kMainColor;
    else if (status == 'Pending')
      return kSecondaryColor;
    else
      return kMainColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: kAppBarStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SimpleStreamBuilder.simpler(
          stream: OrderService().fetchInCompleteOrders(),
          context: context,
          builder: (List<Orders> list) {
            return ListView.builder(
              itemCount: list.length,
              shrinkWrap: false,
              itemBuilder: (context, index) {
                Orders order = list.elementAt(index);
                String status = _statusCheck(order);
                return OrderItemView(
                  title: order.orderCategory,
                  color: _colorCheck(status),
                  onTap: () => navigateTo(
                    context,
                    OrderDetailsPage(orderId: order.id),
                  ),
                  price: (order?.total ?? 'Price pending').toString(),
                  month: AppUtils.getMonthName(order.timestamp.toDate().month),
                  day: order.timestamp.toDate().day.toString(),
                  status: status,
                  orderStatus: order.orderStatus,
                  isComplete: order.isComplete,
                  orderChatId: order.orderChatId,
                  sentBy: order.deliveryBoyId,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
