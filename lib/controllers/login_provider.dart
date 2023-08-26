import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isObsecure = false;

  bool get isObsecure => _isObsecure;


  set isObsecure(bool newState) {
    _isObsecure = newState;
    notifyListeners();
  }
}
