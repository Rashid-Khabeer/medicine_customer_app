import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_customer_app/src/data/models/users_model.dart';
import 'package:medicine_customer_app/src/services/firebase-firestore_service.dart';

class UserService extends MedicineService<UserModel> {
  @override
  String get collectionName => 'Users';

  @override
  UserModel parseModel(DocumentSnapshot document) =>
      UserModel.fromJson(document.data())..id = document.id;

  insertUser(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(user.id)
          .set(user.toJson());
      return user;
    } catch (e) {
      print("exception");
      throw e;
    }
  }

  Future<QuerySnapshot> fetchNumberFirestore(String phoneNo) async =>
      await FirebaseFirestore.instance
          .collection(collectionName)
          .where('PhoneNumber', isEqualTo: phoneNo)
          .get();
}
