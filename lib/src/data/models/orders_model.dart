import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_customer_app/src/data/models/_model.dart';

class Orders extends Model {
  String orderCategory;
  List<String> imagesUrl;
  List<File> files;
  String note;
  String userId;
  double price;
  double shippingPrice;
  double total;
  bool adminBillStatus;
  bool userConfirmStatus;
  bool adminAssignedBoy;
  bool isComplete;
  String orderStatus;
  String deliveryBoyId;
  String deliveredBy;
  String cancelledNote;
  Timestamp timestamp;
  String address;
  String orderChatId;
  bool isReadByAdmin;
  bool isReadByRider;
  String cancelledBy;

  Orders({
    this.price,
    this.adminAssignedBoy,
    this.adminBillStatus,
    this.cancelledNote,
    this.deliveredBy,
    this.deliveryBoyId,
    this.imagesUrl,
    this.note,
    this.orderCategory,
    this.orderStatus,
    this.shippingPrice,
    this.total,
    this.userConfirmStatus,
    this.userId,
    this.timestamp,
    this.files,
    this.isComplete,
    this.address,
    this.orderChatId,
    this.isReadByRider,
    this.isReadByAdmin,
    this.cancelledBy,
  });

  Orders.fromJson(Map<String, dynamic> json) {
    orderCategory = json['OrderCategory'];
    imagesUrl = List<String>();
    (json['ImagesUrl'] as List<dynamic>).forEach((e) => imagesUrl.add(e));
    note = json['Note'];
    userId = json['UserId'];
    price = json['Price'];
    shippingPrice = json['ShippingCharges'];
    total = json['Total'];
    adminBillStatus = json['AdminBillStatus'];
    userConfirmStatus = json['UserConfirmStatus'];
    adminAssignedBoy = json['AdminAssignedBoy'];
    orderStatus = json['OrderStatus'];
    deliveryBoyId = json['DeliveryBoyId'];
    deliveredBy = json['DeliveredBy'];
    cancelledNote = json['CancelledNote'];
    timestamp = json['timestamp'];
    isComplete = json['isComplete'];
    address = json['Address'];
    orderChatId = json['orderChatId'];
    isReadByRider = json['isReadByRider'];
    isReadByAdmin = json['isReadByAdmin'];
    cancelledBy = json['cancelledBy'];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'OrderCategory': orderCategory,
      'ImagesUrl': imagesUrl,
      'Note': note,
      'UserId': userId,
      'Price': price,
      'ShippingCharges': shippingPrice,
      'Total': total,
      'AdminBillStatus': adminBillStatus,
      'UserConfirmStatus': userConfirmStatus,
      'AdminAssignedBoy': adminAssignedBoy,
      'OrderStatus': orderStatus,
      'DeliveryBoyId': deliveryBoyId,
      'DeliveredBy': deliveredBy,
      'CancelledNote': cancelledNote,
      'timestamp': timestamp,
      'isComplete': isComplete,
      'Address': address,
      'orderChatId': orderChatId,
      'isReadByRider': isReadByRider,
      'isReadByAdmin': isReadByAdmin,
      'cancelledBy': cancelledBy,
    };
  }
}
