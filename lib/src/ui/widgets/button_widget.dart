import 'package:medicine_customer_app/src/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends FlatButton {
  ButtonWidget({
    Function onPressed,
    String text,
    Color color=kMainColor,
    double height=50.0,
  }) : super(
          height: height,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          // elevation: 0,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        );
}
