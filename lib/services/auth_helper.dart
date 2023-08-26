import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'config.dart';

class AuthHelper {
  static var client = http.Client();

  // Female
  Future<bool?> login({required String email, required String password}) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiUrl, Config.loginUrl);
    final body = {'email': email, 'password': password};

    var response =
        await http.post(url, headers: requestHeaders, body: jsonEncode(body));

    if (response.statusCode == 200) {
      log('success');
    } else {
      log('fail');
    }
    return null;
  }
}
