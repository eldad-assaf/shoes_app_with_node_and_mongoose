import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_app_with_node_and_mongoose/models/login_res_model.dart';
import 'package:shoes_app_with_node_and_mongoose/models/signup_model.dart';

import '../models/login_model.dart';
import 'config.dart';
//http://10.0.2.2:8000/api/users
class AuthHelper {
  static var client = http.Client();

  Future<bool> login(LoginModel model) async {
    log('login');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiUrl, Config.loginUrl);

    var response = await http.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String userToken = loginResponseModelFromJson(response.body).token;
      final String userId = loginResponseModelFromJson(response.body).token;

      prefs.setString('token', userToken);
      prefs.setString('userId', userId);
      log('should return true');
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> signup(SignupModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiUrl, Config.signupUrl);

    var response = await http.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    log(response.statusCode.toString());
    if (response.statusCode == 201) {
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // final String userToken = loginResponseModelFromJson(response.body).token;
      // final String userId = loginResponseModelFromJson(response.body).token;

      // prefs.setString('token', userToken);
      // prefs.setString('userId', userId);
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> getProfile(String token) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token '
    };
    var url = Uri.http(Config.apiUrl, Config.getUserUrl);

    var response = await http.get(url, headers: requestHeaders);

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
    
      return true;
    } else {
      return false;
    }
  }
}
