import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_customer_app/src/data/models/admin_model.dart';
import 'package:medicine_customer_app/src/services/firebase-firestore_service.dart';

class AdminService extends MedicineService<Admin> {
  String get collectionName => 'Admin';

  @override
  Admin parseModel(DocumentSnapshot document) {
    return Admin.fromJson(document.data())..id = document.id;
  }

  Future<Admin> fetchAdmin() async {
    Admin admin;
    await FirebaseFirestore.instance
        .collection(collectionName)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        admin = parseModel(element);
      });
    });
    return admin;
  }
}
