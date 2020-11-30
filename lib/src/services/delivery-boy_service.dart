import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_customer_app/src/data/models/delivery-boy_model.dart';
import 'package:medicine_customer_app/src/services/firebase-firestore_service.dart';

class DeliveryBoyService extends MedicineService<DeliveryBoy> {
  String get collectionName => 'DeliveryBoys';

  @override
  DeliveryBoy parseModel(DocumentSnapshot document) {
    return DeliveryBoy.fromJson(document.data())..id = document.id;
  }
}
