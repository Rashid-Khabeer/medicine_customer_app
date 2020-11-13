import 'package:medicine_customer_app/src/data/models/_model.dart';

class Orders extends Model {
  String orderCategory;
  List<String> imagesUrl;
  String note;
  String userId;
  double price;
  double shippingPrice;
  double total;
  bool adminBillStatus;
  bool userConfirmStatus;
  bool adminAssignedBoy;
  String orderStatus;
  String deliveryBoyId;
  String deliveredBy;
  String cancelledNote;

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
  });

  Orders.fromJson(Map<String, dynamic> json) {
    orderCategory = json['OrderCategory'];
    imagesUrl = json['ImagesUrl'];
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
    };
  }
}
