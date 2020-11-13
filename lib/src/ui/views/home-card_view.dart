import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:medicine_customer_app/src/constants.dart';

class HomeCardView extends InkWell {
  HomeCardView({
    String title,
    String imagePath,
    Function onTap,
    Color textColor,
  }) : super(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage(imagePath), fit: BoxFit.fill),
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            height: 150.0,
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.all(2.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: kMainColor.withOpacity(0.6),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor, fontSize: 36.0),
              ),
            ),
          ),
        );
}

// class HomeCardView extends StatelessWidget {
//   final String title;
//   final String imagePath;
//   final Function onTap;
//   final Color textColor;
//
//   HomeCardView({this.title, this.onTap, this.imagePath, this.textColor});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: ExactAssetImage(imagePath), fit: BoxFit.fill),
//             borderRadius: BorderRadius.all(Radius.circular(15.0))),
//         height: 150.0,
//         width: double.infinity,
//         child: Container(
//           padding: EdgeInsets.all(2.0),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(15.0)),
//             color: kMainColor.withOpacity(0.6),
//           ),
//           child: Text(
//             title,
//             textAlign: TextAlign.center,
//             style: TextStyle(color: textColor, fontSize: 36.0),
//           ),
//         ),
//       ),
//     );
//   }
// }
