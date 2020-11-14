import 'package:flutter/material.dart';

const kMainColor = Color(0xFF075095);
const kSecondaryColor = Color(0xFF3AD1EE);

const kAppBarStyle = TextStyle(color: kMainColor);
const k16TextStyle = TextStyle(color: kMainColor, fontSize: 16.0);
const k18BlackTextStyle = TextStyle(fontSize: 18.0);
const k18WhiteTextStyle = TextStyle(color: Colors.white, fontSize: 18.0);
const k20BoldTextStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

const kTextInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
