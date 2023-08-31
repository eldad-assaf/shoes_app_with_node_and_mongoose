import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as https;
import 'package:shoes_app_with_node_and_mongoose/models/orders_req.dart';

import 'config.dart';

class PaymentHelper {
  static var client = https.Client();

  Future<String> payment(Order model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      // 'token': 'Bearer $userToken'
    };
    var url = Uri.https(Config.paymentBaseUrl, Config.paymentUrl);
    log(url.toString());
    log(model.userId);
    log(model.cartItems.toString());
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      var payment = jsonDecode(response.body);
      return payment['url'];
    } else {
      return 'failed';
    }
  }
}
