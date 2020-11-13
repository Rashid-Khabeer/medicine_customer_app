import 'package:flutter/material.dart';

void navigateTo(BuildContext context, Widget widget, [bool replace = false]) {
  var navigator;
  if (replace) {
    navigator = Navigator.of(context).pushReplacement;
  } else {
    navigator = Navigator.of(context).push;
  }
  navigator(MaterialPageRoute(builder: (context) => widget));
}

// void navigateToNamed(BuildContext context, Widget widget,
//     [bool replace = false]) {
//   var navigator;
//   if (replace) {
//     navigator = Navigator.of(context).pushReplacement;
//   } else {
//     navigator = Navigator.of(context).push;
//   }
//   navigator();
// }
