import 'package:flutter/material.dart';

class ShowSnackBar extends SnackBar {
  ShowSnackBar({IconData icon, String text})
      : super(
          content: Row(
            children: [
              Icon(icon),
              Text(text),
            ],
          ),
        );
}
