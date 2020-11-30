import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_customer_app/src/constants.dart';
import 'package:medicine_customer_app/src/data/app_data.dart';
import 'package:medicine_customer_app/src/data/models/orders_model.dart';
import 'package:medicine_customer_app/src/services/admin_service.dart';
import 'package:medicine_customer_app/src/services/fcm-message_service.dart';
import 'package:medicine_customer_app/src/services/location_service.dart';
import 'package:medicine_customer_app/src/services/order_service.dart';
import 'package:medicine_customer_app/src/ui/modals/dialogs.dart';
import 'package:medicine_customer_app/src/ui/modals/snackbar.dart';
import 'package:medicine_customer_app/src/ui/pages/order-details_page.dart';
import 'package:medicine_customer_app/src/ui/widgets/image-selector_widget.dart';
import 'package:medicine_customer_app/src/utility/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_customer_app/src/utility/app_utils.dart';

class MedicineOrderPage extends StatefulWidget {
  final category;

  MedicineOrderPage({@required this.category});

  @override
  _MedicineOrderPageState createState() => _MedicineOrderPageState();
}

class _MedicineOrderPageState extends State<MedicineOrderPage> {
  String _note;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<File> _images;
  final _addressController = TextEditingController();
  double _latitude, _longitude;
  double shippingPrice;

  @override
  void initState() {
    super.initState();
    if (widget.category == 'Medicine')
      shippingPrice = 100;
    else if (widget.category == 'Drip/Injection')
      shippingPrice = 200;
    else if (widget.category == 'Tests') shippingPrice = 100;
    _latitude = 0;
    _longitude = 0;
    _getLocation();
  }

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
          title: Text(
            '${widget.category} Order',
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
                          CupertinoIcons.info,
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
                  child: Text(
                    'Details',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            if (value?.isEmpty ?? true) {
                              _latitude = 0;
                              _longitude = 0;
                            }
                          },
                          controller: _addressController,
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(10.0),
                            hintText: 'Enter your address',
                            hintStyle: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          CupertinoIcons.location_solid,
                          color: kMainColor,
                          size: 30.0,
                        ),
                        onPressed: _getLocation,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: TextFormField(
                    onChanged: (value) => _note = value,
                    style: TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10.0),
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

  _getLocation() async {
    LocationService _location = LocationService();
    await _location.getCurrentLocation();
    _latitude = _location.latitude;
    _longitude = _location.longitude;
    print(
        'Latitude: ${_location.latitude} and Longitude: ${_location.longitude}');
    if (_location.place != null) {
      print(_location.place);
      _addressController.text =
          '${_location.place.street} ${_location.place.subLocality} ${_location.place.locality}';
    }
  }

  _orderClicked() async {
    if (!(await AppUtils.checkInternet())) {
      ErrorDialog(context: context, content: 'No Internet Connection').show();
      return;
    }
    if (_addressController.text?.isEmpty ?? true) {
      _scaffoldKey.currentState.showSnackBar(
        ShowSnackBar(
          icon: Icons.error,
          text: 'Please Enter Your Address or select Current Location',
        ),
      );
      return;
    }
    bool _flag = false;
    if (_note?.isNotEmpty ?? false) {
      _flag = true;
    }
    if (_images?.isNotEmpty ?? false) {
      _flag = true;
    }
    if (_flag) {
      ConfirmDialog(
        context: context,
        content: 'This app is only for Multan, Order if you are from Multan',
        function: _orderAction,
      ).show();
    } else {
      _scaffoldKey.currentState.showSnackBar(
        ShowSnackBar(
          icon: Icons.error,
          text: 'Please enter medicine info or upload prescription',
        ),
      );
    }
  }

  _orderAction() async {
    Navigator.of(context).pop();
    WaitingDialog(context: context).show();
    Orders _order = Orders(
      adminAssignedBoy: false,
      adminBillStatus: false,
      note: _note ?? '',
      orderCategory: widget.category,
      userConfirmStatus: false,
      userId: AppData.uId,
      timestamp: Timestamp.now(),
      files: _images,
      isComplete: false,
      address: _addressController.text,
      orderStatus: 'InComplete',
      isReadByAdmin: false,
      isReadByRider: false,
      latitude: _latitude,
      longitude: _longitude,
      shippingPrice: shippingPrice,
    );
    Orders o = await OrderService().insertOrder(_order);
    if (o == null) {
      Navigator.of(context).pop();
      ErrorDialog(context: context, content: 'No Internet Connection').show();
    } else {
      if (o.imagesUrl == null) {
        Navigator.of(context).pop();
        _scaffoldKey.currentState.showSnackBar(
          ShowSnackBar(
            icon: Icons.error,
            text:
                'Your order is submitted offline, connected to internet your order will be submitted',
          ),
        );
        return;
      }
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      _sendFcm(o.address);
      navigateTo(
        context,
        OrderDetailsPage(orderId: o.id),
      );
    }
  }

  _sendFcm(String message) async {
    String adminToken = (await AdminService().fetchAdmin()).token;
    await FcmMessageService.sendFcmMessage(
      title: 'New Order',
      message: 'New Order from $message',
      token: adminToken,
    );
  }
}
