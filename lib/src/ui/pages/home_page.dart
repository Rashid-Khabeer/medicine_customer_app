import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';
import 'package:medicine_customer_app/src/constants.dart';
import 'package:medicine_customer_app/src/data/app_data.dart';
import 'package:medicine_customer_app/src/services/order_service.dart';
import 'package:medicine_customer_app/src/ui/pages/cart_page.dart';
import 'package:medicine_customer_app/src/ui/pages/edit-address_page.dart';
import 'package:medicine_customer_app/src/ui/pages/medicine-order_page.dart';
import 'package:medicine_customer_app/src/ui/pages/ordes-history_page.dart';
import 'package:medicine_customer_app/src/ui/views/home-card_view.dart';
import 'package:medicine_customer_app/src/utility/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5.0, top: 5.0),
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(
                    CupertinoIcons.cart,
                    color: kMainColor,
                    size: 28.0,
                  ),
                  onPressed: () => navigateTo(context, CartPage()),
                ),
                Positioned(
                  right: 11,
                  top: 5,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: OrderService().fetchInComplete(),
                    builder: (context, list) {
                      if (list.data.size > 0) {
                        return Container(
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          child: Text(
                            '${list.data.size}',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 10.0),
                          ),
                        );
                      } else
                        return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
        title: Text(
          'Home',
          style: kAppBarStyle,
        ),
      ),
      drawer: Drawer(
        elevation: 1.0,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                '${AppData.uName}',
                style: TextStyle(fontSize: 18.0),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  CupertinoIcons.person,
                  size: 65.0,
                ),
              ),
              accountEmail: Text('${AppData.phoneNo}'),
            ),
            ListTile(
              title: Text('History'),
              leading: Icon(Icons.history),
              onTap: () {
                Navigator.of(context).pop();
                navigateTo(context, OrderHistoryPage());
              },
            ),
            Container(height: 0.5, color: Colors.grey),
            ExpansionTile(
              title: Text('Settings'),
              leading: Icon(CupertinoIcons.settings),
              children: [
                ListTile(
                  title: Text('Edit Address'),
                  leading: Icon(CupertinoIcons.location),
                  onTap: () => navigateTo(context, EditAddressPage()),
                ),
              ],
            ),
            Container(height: 0.5, color: Colors.grey),
            ListTile(
              title: Text('About Us'),
              leading: Icon(CupertinoIcons.info),
            ),
            Container(height: 0.5, color: Colors.grey),
            ListTile(
              title: Text('Exit'),
              leading: Icon(Icons.exit_to_app),
            ),
            Container(height: 0.5, color: Colors.grey),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: TweenAnimationBuilder(
                      duration: Duration(milliseconds: 600),
                      tween: Tween<double>(begin: 0, end: 1),
                      curve: Curves.easeIn,
                      child: Text(
                        'Hello! \n${AppData.uName}',
                        style: TextStyle(
                            color: kMainColor,
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold),
                      ),
                      builder: (context, _val, child) {
                        return Padding(
                          padding: EdgeInsets.only(top: _val * 20),
                          child: child,
                        );
                      }),
                ),
                Text(
                  'Medicine at Home Services',
                  style: k16TextStyle,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: HomeCardView(
                    title: 'Medicine',
                    imagePath: 'assets/images/medicine.jpg',
                    onTap: () => navigateTo(context, MedicineOrderPage()),
                    textColor: Colors.white,
                  ),
                ),
                HomeCardView(
                  title: 'DRIP/INJECTION',
                  imagePath: 'assets/images/drips.jpg',
                  onTap: () => navigateTo(context, MedicineOrderPage()),
                  textColor: Colors.white,
                ),
                SizedBox(height: 15.0),
                HomeCardView(
                  title: 'TESTS',
                  imagePath: 'assets/images/tests.jpg',
                  onTap: () => navigateTo(context, MedicineOrderPage()),
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
