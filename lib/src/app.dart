import 'package:medicine_customer_app/src/constants.dart';
import 'package:medicine_customer_app/src/data/app_data.dart';
import 'package:medicine_customer_app/src/ui/pages/home_page.dart';
import 'package:medicine_customer_app/src/ui/pages/sigin_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class MedicineUserApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp();
//     return CupertinoApp();
//   }
// }

class MedicineUserApp extends MaterialApp {
  MedicineUserApp()
      : super(
          title: 'Medicine At Home',
          theme: ThemeData(
            primaryColor: kMainColor,
            appBarTheme: AppBarTheme(
              color: Colors.white,
              iconTheme: IconThemeData(color: kMainColor),
              textTheme: TextTheme(
                button: TextStyle(color: kMainColor),
              ),
            ),
            accentColor: kMainColor,
            cupertinoOverrideTheme: CupertinoThemeData(
              primaryColor: kMainColor,
            ),
            cursorColor: kMainColor,
          ),
          home: AppData.isSignedIn ? HomePage() : SigninPage(),
        );
}
