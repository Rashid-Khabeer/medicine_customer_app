import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowSnackBar extends SnackBar {
  ShowSnackBar({IconData icon, String text})
      : super(
          content: Row(
            children: [
              Icon(icon),
              SizedBox(width: 5.0),
              Expanded(child: Text(text)),
            ],
          ),
        );
}
