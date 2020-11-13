import 'package:medicine_customer_app/src/constants.dart';
import 'package:medicine_customer_app/src/ui/pages/order-details_page.dart';
import 'package:medicine_customer_app/src/ui/views/order-item_view.dart';
import 'package:medicine_customer_app/src/utility/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: TextStyle(color: kMainColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              OrderItemView(
                color: kMainColor,
                title: 'Medicine',
                day: '11',
                month: 'Oct',
                price: '2000RS',
                status: 'Requested',
                onTap: () => navigateTo(context, OrderDetailsPage()),
              ),
              OrderItemView(
                color: kSecondaryColor,
                title: 'Drip',
                day: '10',
                month: 'Oct',
                price: '2000RS',
                status: 'Pending',
                onTap: () => navigateTo(context, OrderDetailsPage()),
              ),
              OrderItemView(
                color: Colors.green,
                title: 'Tests',
                day: '11',
                month: 'Oct',
                price: '2000RS',
                status: 'Confirmed',
                onTap: () => navigateTo(context, OrderDetailsPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
