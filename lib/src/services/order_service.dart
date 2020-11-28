import 'dart:io';
import 'package:medicine_customer_app/src/data/app_data.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:medicine_customer_app/src/data/models/orders_model.dart';
import 'package:medicine_customer_app/src/services/firebase-firestore_service.dart';

class OrderService extends MedicineService<Orders> {
  @override
  String get collectionName => 'Orders';

  @override
  Orders parseModel(DocumentSnapshot document) {
    return Orders.fromJson(document.data())..id = document.id;
  }

  insertOrder(Orders order) async {
    if (order.files?.isNotEmpty ?? false) {
      order.imagesUrl = await uploadImages(order.files);
      if (order.imagesUrl.isEmpty) return null;
    } else
      order.imagesUrl = [];
    Orders insertedOrder = await super.insertFirestore(order);
    if (insertedOrder == null) {
      insertedOrder = Orders(imagesUrl: null);
    }
    return insertedOrder;
  }

  static Future<List<String>> uploadImages(List<File> images) async {
    List<String> urls = List();
    for (File image in images) {
      String fileName = basename(image.path);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
      try {
        await uploadTask.onComplete.timeout(Duration(seconds: 5));
      } catch (_) {
        return urls;
      }
      var downUrl = await firebaseStorageRef.getDownloadURL();
      String url = downUrl.toString();
      urls.add(url);
    }
    return urls;
  }

  Stream<QuerySnapshot> fetchInComplete() async* {
    final snapshots = FirebaseFirestore.instance
        .collection(collectionName)
        .where('UserId', isEqualTo: AppData.uId)
        .where('isComplete', isEqualTo: false)
        .where('cancelledBy', isNull: true)
        .snapshots();
    yield* snapshots;
  }

  Stream<List<Orders>> fetchInCompleteOrders() => FirebaseFirestore.instance
      .collection(collectionName)
      .where('UserId', isEqualTo: AppData.uId)
      .where('isComplete', isEqualTo: false)
      .where('cancelledBy', isNull: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((document) => parseModel(document)).toList());

  Stream<List<Orders>> fetchCompleteOrders() => FirebaseFirestore.instance
      .collection(collectionName)
      .where('UserId', isEqualTo: AppData.uId)
      .where('isComplete', isEqualTo: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((document) => parseModel(document)).toList());

  Stream<Orders> fetchSingleOrder(String id) => FirebaseFirestore.instance
      .collection(collectionName)
      .doc(id)
      .snapshots()
      .map((event) => parseModel(event));

  Stream<List<Orders>> fetchAdminCancelledOrders() {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where('UserId', isEqualTo: AppData.uId)
        .where('isComplete', isEqualTo: false)
        .where('cancelledBy', isEqualTo: 'admin')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((document) => parseModel(document)).toList());
  }

  Stream<List<Orders>> fetchUserCancelledOrders() {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where('UserId', isEqualTo: AppData.uId)
        .where('isComplete', isEqualTo: false)
        .where('cancelledBy', isEqualTo: 'user')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((document) => parseModel(document)).toList());
  }
}
