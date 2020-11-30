import 'dart:convert';
import 'package:http/http.dart' as http;

class FcmMessageService {
  static String authorizationKey =
      "key=AAAAOhH0POU:APA91bHkC6skLJBN81BYdVgT_w1N6mWjd1jKyG18nqAzh4oee31i0L1Pc92pa_PZBBuU8XReAcYB6t5nGlZ4-BBmC9Qz4uwKPylY9WmOAE5a0X_QWyJDRnqHyBme8XaRbmyg0gWM9-ZU";

  static Future<bool> sendFcmMessage({
    String title,
    String message,
    String token,
  }) async {
    try {
      var url = 'https://fcm.googleapis.com/fcm/send';
      var header = {
        "Content-Type": "application/json",
        "Authorization": "$authorizationKey",
      };
      var request = {
        "notification": {
          "title": title,
          "text": message,
          "sound": "default",
          "color": "#990000",
        },
        "priority": "high",
        "to": "$token",
        // "data": {
        //   "body": "Body of Your Notification in Data",
        //   "title": "Title of Your Notification in Title",
        //   "key_1": "Value for key_1",
        //   "key_2": "Value for key_2"
        // },
      };
      await http.post(url, headers: header, body: json.encode(request));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
