import 'dart:io';
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
    if (order.files?.isNotEmpty ?? false)
      order.imagesUrl = await uploadImages(order.files);
    else
      order.imagesUrl = [];
    return await super.insertFirestore(order);
  }

  static Future<List<String>> uploadImages(List<File> images) async {
    List<String> urls = List();
    for (File image in images) {
      String fileName = basename(image.path);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
      await uploadTask.onComplete;
      var downUrl = await firebaseStorageRef.getDownloadURL();
      String url = downUrl.toString();
      urls.add(url);
    }
    return urls;
  }
}
