import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_app_with_node_and_mongoose/models/login_model.dart';
import 'package:shoes_app_with_node_and_mongoose/models/signup_model.dart';
import 'package:shoes_app_with_node_and_mongoose/services/auth_helper.dart';

class LoginNotifier extends ChangeNotifier {
  bool _isObsecure = false;
  bool get isObsecure => _isObsecure;
  set isObsecure(bool newState) {
    _isObsecure = newState;
    notifyListeners();
  }

//////////////////////////////////////////////////////////
  bool _processing = false;
  bool get processing => _processing;
  set processing(bool newState) {
    _processing = newState;
    notifyListeners();
  }

//////////////////////////////////////////////////////////

  bool _loginResponseBool = false;
  bool get loginResponseBool => _loginResponseBool;
  set loginResponseBool(bool newState) {
    _loginResponseBool = newState;
    notifyListeners();
  }

//////////////////////////////////////////////////////////
  bool _responseBool = false;
  bool get responseBool => _responseBool;
  set responseBool(bool newState) {
    _responseBool = newState;
    notifyListeners();
  }

//////////////////////////////////////////////////////////
  bool? _loggedIn;
  bool get loggedIn => _loggedIn ?? false;
  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

//////////////////////////////////////////////////////////
  Future<bool> userLogin(LoginModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    processing = true;
    bool response = await AuthHelper().login(model);
    processing = false;
    _loginResponseBool = response;
    loggedIn = prefs.getBool('isLogged') ?? false;
    return loginResponseBool;
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userId');
    await prefs.setBool('isLogged', false);
    loggedIn = prefs.getBool('isLogged') ?? false;
  }

  Future<bool> registerUser(SignupModel model) async {
    responseBool = await AuthHelper().signup(model);
    return responseBool;
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool('isLogged') ?? false;
  }
}
