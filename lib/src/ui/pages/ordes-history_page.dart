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

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: kAppBarStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SimpleStreamBuilder.simpler(
          stream: OrderService().fetchCompleteOrders(),
          context: context,
          builder: (List<Orders> list) {
            return ListView.builder(
              itemCount: list.length,
              shrinkWrap: false,
              itemBuilder: (context, index) {
                Orders order = list.elementAt(index);
                return OrderItemView(
                  title: order.orderCategory,
                  color: Colors.green,
                  onTap: () => navigateTo(
                    context,
                    OrderDetailsPage(orderId: order.id),
                  ),
                  price: (order?.total ?? 'Price pending').toString(),
                  month: AppUtils.getMonthName(order.timestamp.toDate().month),
                  day: order.timestamp.toDate().day.toString(),
                  status: 'Completed',
                  orderStatus: order.orderStatus,
                  isComplete: order.isComplete,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
