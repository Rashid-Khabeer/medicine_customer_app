import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_customer_app/src/data/app_data.dart';
import 'package:medicine_customer_app/src/data/models/orders_model.dart';
import 'package:medicine_customer_app/src/services/order_service.dart';
import 'package:medicine_customer_app/src/ui/modals/dialogs.dart';
import 'package:medicine_customer_app/src/ui/modals/snackbar.dart';
import 'package:medicine_customer_app/src/ui/pages/edit-address_page.dart';
import 'package:medicine_customer_app/src/ui/pages/order-details_page.dart';
import 'package:medicine_customer_app/src/ui/widgets/image-selector_widget.dart';
import 'package:medicine_customer_app/src/utility/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class MedicineOrderPage extends StatefulWidget {
  @override
  _MedicineOrderPageState createState() => _MedicineOrderPageState();
}

class _MedicineOrderPageState extends State<MedicineOrderPage> {
  String _note;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<File> _images;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Order',
            style: kAppBarStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  color: kSecondaryColor,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.location_solid,
                          color: kMainColor,
                        ),
                        Text(
                          'Delivery only for ',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Multan',
                          style: TextStyle(
                            fontSize: 16.0,
                            decoration: TextDecoration.underline,
                            color: kMainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' 100Rs',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Details',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => navigateTo(context, EditAddressPage()),
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: kMainColor,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.home,
                        size: 40.0,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          'Address',
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.grey.shade800),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  child: TextFormField(
                    onChanged: (value) => _note = value,
                    style: TextStyle(fontSize: 20.0),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.text_snippet_outlined,
                        size: 30.0,
                        color: Colors.black,
                      ),
                      hintText: 'Note or medicine info',
                      hintStyle: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: ImageSelector(
                    onChanged: (images) => _images = images,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 0,
          label: Text('Order'),
          icon: Icon(Icons.bookmark_border),
          onPressed: _orderClicked,
        ),
      ),
    );
  }

  _orderClicked() async {
    bool _flag = false;
    if (_note?.isNotEmpty ?? false) {
      _flag = true;
    }
    if (_images?.isNotEmpty ?? false) {
      _flag = true;
    }
    if (_flag) {
      WaitingDialog(context: context).show();
      Orders _order = Orders(
        adminAssignedBoy: false,
        adminBillStatus: false,
        note: _note ?? '',
        orderCategory: 'Medicine',
        userConfirmStatus: false,
        userId: AppData.uId,
        timestamp: Timestamp.now(),
        files: _images,
        isComplete: false,
        address: 'Street no 2, chah bohr wala sher shah road cannt multan',
        orderStatus: 'InComplete',
      );
      Orders o = await OrderService().insertOrder(_order);
      if (o != null) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        navigateTo(
          context,
          OrderDetailsPage(orderId: o.id),
        );
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(
        ShowSnackBar(
          icon: Icons.error,
          text: 'Please enter medicine info or upload prescription',
        ),
      );
    }
  }
}
