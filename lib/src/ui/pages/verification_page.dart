import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_customer_app/src/constants.dart';
import 'package:medicine_customer_app/src/data/models/users_model.dart';
import 'package:medicine_customer_app/src/services/user_service.dart';
import 'package:medicine_customer_app/src/ui/modals/dialogs.dart';
import 'package:medicine_customer_app/src/ui/modals/snackbar.dart';
import 'package:medicine_customer_app/src/ui/pages/home_page.dart';
import 'package:medicine_customer_app/src/ui/widgets/button_widget.dart';
import 'package:medicine_customer_app/src/utility/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {
  final String userName;
  final String phoneNumber;

  VerificationPage({this.userName, this.phoneNumber});

  @override
  State<StatefulWidget> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  String _code;
  bool _clickable = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String _verificationId;

  _firebaseAuthentication(String phone) async {
    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 90),
      verificationCompleted: (AuthCredential credential) async {
        WaitingDialog(context: context).show();
        _signInUser(credential);
      },
      verificationFailed: (FirebaseAuthException ex) {
        _scaffoldKey.currentState.showSnackBar(
          ShowSnackBar(
            icon: Icons.error,
            text: 'OTP did not match',
          ),
        );
        print(ex);
        if (ex.code == 'invalid-phone-number') {
          print('The provided phone number is not valid');
        }
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        print('Sent');
        _clickable = true;
        _scaffoldKey.currentState.showSnackBar(
          ShowSnackBar(
            icon: Icons.info,
            text: 'OTP Sent!',
          ),
        );
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        print('TimeOut');
      },
    );
  }

  _signInUser(AuthCredential credential) async {
    UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    User user = userCredential.user;
    if (user != null) {
      _saveUser(user.uid);
    } else {
      print('Error');
    }
  }

  _saveUser(String userId) async {
    UserModel _user = UserModel(
      name: widget.userName,
      phoneNumber: widget.phoneNumber,
    );
    _user..id = userId;
    UserService().fetchOneFirestore(userId).then((value) {
      if (value != null) {
        //update
      } else {
        //insert
      }
    });
    UserModel _insertedUser = await UserService().insertUser(_user);
    if (_insertedUser != null) {
      Navigator.of(context).pop();
      navigateTo(context, HomePage(), true);
    }
  }

  @override
  void initState() {
    super.initState();
    _firebaseAuthentication(widget.phoneNumber);
  }

  _pressedAction() {
    if (_clickable) {
      if (_formKey.currentState.validate()) {
        WaitingDialog(context: context).show();
        _formKey.currentState.save();
        AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: _code,
        );
        _signInUser(authCredential);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              'Verification',
              style: TextStyle(color: kMainColor),
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: MediaQuery.of(context).size.height / 4,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 30.0, bottom: 5.0, left: 5.0, right: 5.0),
                      child: Text(
                        'We have sent an OTP to ${widget.phoneNumber}',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 5.0, right: 5.0, bottom: 20.0),
                      child: Text(
                        'Please Enter it below to continue',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    TextFormField(
                      onSaved: (value) => _code = value,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      validator: (value) => value.isEmpty
                          ? 'Please Enter Code'
                          : value.length != 6
                              ? 'Please enter valid code'
                              : null,
                      decoration:
                          kTextInputDecoration.copyWith(labelText: 'OTP'),
                    ),
                    SizedBox(height: 20.0),
                    ButtonWidget(
                      text: 'Confirm',
                      onPressed: _clickable ? _pressedAction() : null,
                      // onPressed: _pressedAction,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
