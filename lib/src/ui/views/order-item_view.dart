import 'package:medicine_customer_app/src/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderItemView extends InkWell {
  OrderItemView({
    String day,
    String month,
    String title,
    String price,
    String status,
    Color color,
    Function onTap,
  }) : super(
          onTap: onTap,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(day, style: k20BoldTextStyle),
                          Text(month, style: k20BoldTextStyle),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                              width: 1.0, height: 45.0, color: Colors.grey)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: k18BlackTextStyle),
                            SizedBox(height: 5.0),
                            Text(price, style: k18BlackTextStyle),
                          ],
                        ),
                      ),
                      Icon(
                        CupertinoIcons.tag_solid,
                        color: color,
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
                  child: Container(height: 1.0, color: Colors.grey),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
                  padding: EdgeInsets.all(10.0),
                  child: Text(status, style: k18WhiteTextStyle),
                ),
              ],
            ),
          ),
        );
}

// class OrderItemView extends StatelessWidget {
//   final String day, month, title, price, status;
//   final Color color;
//   final Function onTap;
//
//   OrderItemView({this.onTap,
//     this.title,
//     this.color,
//     this.status,
//     this.day,
//     this.month,
//     this.price});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Card(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Padding(
//               padding: EdgeInsets.all(15.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     children: [
//                       Text(day, style: k20BoldTextStyle),
//                       Text(month, style: k20BoldTextStyle),
//                     ],
//                   ),
//                   Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10.0),
//                       child: Container(
//                           width: 1.0, height: 45.0, color: Colors.grey)),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(title, style: k18BlackTextStyle),
//                         SizedBox(height: 5.0),
//                         Text(price, style: k18BlackTextStyle),
//                       ],
//                     ),
//                   ),
//                   Icon(
//                     CupertinoIcons.tag_solid,
//                     color: color,
//                     size: 30.0,
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
//               child: Container(height: 1.0, color: Colors.grey),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 color: color,
//                 borderRadius: BorderRadius.all(Radius.circular(5.0)),
//               ),
//               margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
//               padding: EdgeInsets.all(10.0),
//               child: Text(status, style: k18WhiteTextStyle),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }