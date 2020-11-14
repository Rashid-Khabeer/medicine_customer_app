import 'package:medicine_customer_app/src/constants.dart';
import 'package:medicine_customer_app/src/ui/modals/snackbar.dart';
import 'package:medicine_customer_app/src/ui/pages/verification_page.dart';
import 'package:medicine_customer_app/src/ui/widgets/button_widget.dart';
import 'package:medicine_customer_app/src/utility/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _key = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _name;
  String _phone;

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
            'Signin',
            style: kAppBarStyle,
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                  ),
                  TextFormField(
                    onSaved: (value) => _name = value,
                    decoration:
                        kTextInputDecoration.copyWith(labelText: 'Name'),
                    keyboardType: TextInputType.name,
                    validator: (value) =>
                        value.isEmpty ? 'Please enter Name' : null,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      onSaved: (value) => _phone = value,
                      decoration: kTextInputDecoration.copyWith(
                        labelText: 'Phone Number',
                        hintText: '3xxxxxxxxx',
                        prefix: Container(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text('+92'),
                        ),
                      ),
                      validator: (value) => value.isEmpty
                          ? 'Please enter Name'
                          : value.length != 10
                              ? 'Please enter valid Phone'
                              : null,
                    ),
                  ),
                  ButtonWidget(
                    onPressed: _continueAction,
                    text: 'Continue',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _continueAction() {
    if (_key.currentState.validate()) {
      _scaffoldKey.currentState.showSnackBar(
        ShowSnackBar(icon: Icons.info_outline, text: 'Sending OTP'),
      );
      _key.currentState.save();
      navigateTo(
        context,
        VerificationPage(
          userName: _name,
          phoneNumber: '+92' + _phone,
        ),
        true,
      );
    }
  }
}
