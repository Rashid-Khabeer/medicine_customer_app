import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medicine_customer_app/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MedicineUserApp());
}
