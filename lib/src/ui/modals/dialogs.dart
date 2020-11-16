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
              ),
            ),
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

class InfoDialog extends Alert {
  InfoDialog({
    BuildContext context,
    String content,
  }) : super(
          context: context,
          title: 'Information',
          image: Icon(Icons.info, color: Colors.green),
          desc: content,
          buttons: [
            DialogButton(
              width: 50.0,
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.green,
            ),
          ],
          style: AlertStyle(
            isCloseButton: false,
            titleStyle:
                TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        );
}

class ErrorDialog extends Alert {
  ErrorDialog({
    BuildContext context,
    String content,
  }) : super(
          image: Icon(Icons.warning, color: Colors.red),
          context: context,
          title: 'Error',
          desc: content,
          buttons: [
            DialogButton(
              width: 50.0,
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
            ),
          ],
          style: AlertStyle(
            isCloseButton: false,
            titleStyle:
                TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        );
}
