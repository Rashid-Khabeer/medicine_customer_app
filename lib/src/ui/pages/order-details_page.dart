import 'package:medicine_customer_app/src/constants.dart';
import 'package:medicine_customer_app/src/ui/pages/chat_page.dart';
import 'package:medicine_customer_app/src/ui/widgets/button_widget.dart';
import 'package:medicine_customer_app/src/utility/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatefulWidget {
  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
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
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
            child: Wrap(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                  child: Text(
                    'Medicine',
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
                                  child:
                                      Text('Price', style: k18BlackTextStyle),
                                ),
                                Text('200Rs', style: k18BlackTextStyle),
                              ],
                            ),
                            SizedBox(height: 25.0),
                            Row(
                              children: [
                                Expanded(
                                  child: Text('Shipping Charges',
                                      style: k18BlackTextStyle),
                                ),
                                Text('100Rs', style: k18BlackTextStyle),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 23.0, bottom: 5.0),
                              child: Container(height: 1.0, color: Colors.grey),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child:
                                      Text('Total', style: k18BlackTextStyle),
                                ),
                                Text('300Rs', style: k18BlackTextStyle),
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
                          child: Text('Seller Note:',
                              style: k16TextStyle.copyWith(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: Text(
                            'Your order is ready to ship',
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      height: 40.0,
                      text: 'Confirm',
                      onPressed: () {},
                    ),
                    SizedBox(width: 5.0),
                    ButtonWidget(
                      height: 40.0,
                      onPressed: () {},
                      text: 'Cancel',
                      color: Colors.red,
                    ),
                  ],
                ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
