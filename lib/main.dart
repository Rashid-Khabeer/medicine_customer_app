import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medicine_customer_app/src/app.dart';
import 'package:medicine_customer_app/src/data/app_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
  SharedPreferences sp = await SharedPreferences.getInstance();
  // sp.setString('userId', 'xRx19hA4qKPrgaXIOPRIrdKlDIB3');
  // sp.setString('userName', 'Rashid ');
  // sp.setString('userPhone', '+923127191646');
  // AppData.isSignedIn = true;
  // await sp.clear();
  if (sp.containsKey('userId')) {
    AppData.isSignedIn = true;
    AppData.uId = sp.getString('userId');
    AppData.uName = sp.getString('userName');
    AppData.phoneNo = sp.getString('userPhone');
  } else
    AppData.isSignedIn = false;
  runApp(MedicineUserApp());
}
