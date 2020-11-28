import 'package:flutter/material.dart';
import 'package:medicine_customer_app/src/constants.dart';
import 'package:medicine_customer_app/src/data/models/orders_model.dart';
import 'package:medicine_customer_app/src/services/order_service.dart';
import 'package:medicine_customer_app/src/ui/pages/order-details_page.dart';
import 'package:medicine_customer_app/src/ui/views/order-item_view.dart';
import 'package:medicine_customer_app/src/ui/widgets/simple-stream-builder_widget.dart';
import 'package:medicine_customer_app/src/utility/app_utils.dart';
import 'package:medicine_customer_app/src/utility/navigator.dart';

class UserCancelledView extends StatelessWidget {
  String _statusCheck(Orders order) {
    if (order.cancelledBy?.isNotEmpty ?? false) return 'Cancelled';
    if (order.adminBillStatus) {
      if (order.userConfirmStatus)
        return 'Confirmed';
      else
        return 'Pending';
    } else
      return 'Requested';
  }

  Color _colorCheck(String status) {
    if (status == 'Confirmed')
      return Colors.green;
    else if (status == 'Requested')
      return kMainColor;
    else if (status == 'Pending')
      return kSecondaryColor;
    else if (status == 'Cancelled')
      return Colors.red;
    else
      return kMainColor;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleStreamBuilder.simpler(
      stream: OrderService().fetchUserCancelledOrders(),
      context: context,
      builder: (List<Orders> list) {
        return ListView.builder(
          padding: EdgeInsets.all(5.0),
          itemCount: list.length,
          shrinkWrap: false,
          itemBuilder: (context, index) {
            Orders order = list.elementAt(index);
            String status = _statusCheck(order);
            return OrderItemView(
              title: order.orderCategory,
              color: _colorCheck(status),
              onTap: () => navigateTo(
                context,
                OrderDetailsPage(orderId: order.id),
              ),
              price: (order?.total ?? 'Price pending').toString(),
              month: AppUtils.getMonthName(order.timestamp.toDate().month),
              day: order.timestamp.toDate().day.toString(),
              status: status,
              orderStatus: order.orderStatus,
              isComplete: order.isComplete,
              orderChatId: order.orderChatId,
              sentBy: order.deliveryBoyId,
            );
          },
        );
      },
    );
  }
}
