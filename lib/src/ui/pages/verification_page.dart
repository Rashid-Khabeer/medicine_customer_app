import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_customer_app/src/constants.dart';
import 'package:medicine_customer_app/src/data/app_data.dart';
import 'package:medicine_customer_app/src/data/models/users_model.dart';
import 'package:medicine_customer_app/src/services/user_service.dart';
import 'package:medicine_customer_app/src/ui/modals/dialogs.dart';
import 'package:medicine_customer_app/src/ui/modals/snackbar.dart';
import 'package:medicine_customer_app/src/ui/pages/home_page.dart';
import 'package:medicine_customer_app/src/ui/pages/sigin_page.dart';
import 'package:medicine_customer_app/src/ui/widgets/button_widget.dart';
import 'package:medicine_customer_app/src/utility/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        WaitingDialog(context: context).show();
        _signInUser(credential);
      },
      verificationFailed: (FirebaseAuthException ex) async {
        _scaffoldKey.currentState.showSnackBar(
          ShowSnackBar(
            icon: Icons.error,
            text: '${ex.code}, Please send Again',
          ),
        );
        await Future.delayed(Duration(seconds: 4));
        navigateTo(context, SigninPage(), true);
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        setState(() => _clickable = true);
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
    await _auth.signInWithCredential(credential).then((result) {
      if (result.user != null) {
        _saveUser(result.user.uid);
      } else {
        print('Error');
      }
    }).catchError((e) {
      Navigator.of(context).pop();
      _scaffoldKey.currentState.showSnackBar(
        ShowSnackBar(
          icon: Icons.error,
          text: '${e.code}',
        ),
      );
    });
  }

  _saveUser(String userId) {
    UserModel _user = UserModel(
      name: widget.userName,
      phoneNumber: widget.phoneNumber,
    );
    _user..id = userId;
    UserModel _insertedUser;
    UserService().fetchNumberFirestore(_user.phoneNumber).then((value) async {
      if (value.docs?.isEmpty ?? true) {
        _insertedUser = await UserService().insertUser(_user);
      } else {
        UserModel u = UserService().parseModel(value.docs.first);
        u.name = _user.name;
        await UserService().updateFirestore(u);
        _insertedUser = u;
      }
      if (_insertedUser != null) {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('userId', _insertedUser.id);
        sp.setString('userName', _insertedUser.name);
        sp.setString('userPhone', _insertedUser.phoneNumber);
        AppData.isSignedIn = true;
        AppData.uId = _insertedUser.id;
        AppData.uName = _insertedUser.name;
        AppData.phoneNo = _insertedUser.phoneNumber;
        Navigator.of(context).pop();
        navigateTo(context, HomePage(), true);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _firebaseAuthentication(widget.phoneNumber);
  }

  _pressedAction() {
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
              style: kAppBarStyle,
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
                      onPressed: _clickable ? _pressedAction : null,
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
