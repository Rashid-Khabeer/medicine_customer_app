import 'package:medicine_customer_app/src/ui/pages/order-details_page.dart';
import 'package:medicine_customer_app/src/ui/views/order-item_view.dart';
import 'package:medicine_customer_app/src/utility/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

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
          style: TextStyle(color: kMainColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              OrderItemView(
                color: Colors.green,
                title: 'Medicine',
                day: '11',
                month: 'Oct',
                price: '2000RS',
                status: 'Completed',
                onTap: () =>navigateTo(context, OrderDetailsPage()),
              ),
              OrderItemView(
                color: Colors.green,
                title: 'Drip',
                day: '10',
                month: 'Oct',
                price: '2000RS',
                status: 'Completed',
                onTap: () =>navigateTo(context, OrderDetailsPage()),
              ),
              OrderItemView(
                color: Colors.green,
                title: 'Tests',
                day: '09',
                month: 'Oct',
                price: '2000RS',
                status: 'Completed',
                onTap: () =>navigateTo(context, OrderDetailsPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
