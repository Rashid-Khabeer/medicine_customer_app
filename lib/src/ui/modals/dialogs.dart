import 'package:medicine_customer_app/src/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ConfirmDialog extends Alert {
  ConfirmDialog({
    BuildContext context,
    String content,
    Function function,
  }) : super(
          image: Icon(Icons.done, color: kMainColor),
          context: context,
          title: 'Confirmation',
          desc: content,
          buttons: [
            DialogButton(
                onPressed: function,
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.white),
                )),
            DialogButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'No',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
            ),
          ],
          style: AlertStyle(
            isCloseButton: false,
            titleStyle:
                TextStyle(color: kMainColor, fontWeight: FontWeight.bold),
          ),
        );
}

class WaitingDialog extends Alert {
  WaitingDialog({BuildContext context})
      : super(
          type: AlertType.none,
          title: 'Please Wait',
          context: context,
          content: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text(
                  'Request is processing',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          style: AlertStyle(
            isButtonVisible: false,
            isOverlayTapDismiss: false,
            isCloseButton: false,
          ),
        );
}
