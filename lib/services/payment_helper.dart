import 'dart:convert';

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
    var url = Uri.http(Config.apiUrl, Config.paymentUrl);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      
    } else {
      throw Exception('Failed to do payment');
    }
  }
}
