import 'package:flutter/material.dart';
import 'package:shoes_app_with_node_and_mongoose/models/add_to_cart.dart';
import 'package:shoes_app_with_node_and_mongoose/services/cart_helper.dart';

class CartNotifier extends ChangeNotifier {
  bool _processing = false;
  bool get processing => _processing;
  set processing(bool newState) {
    _processing = newState;
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

  Future<bool> addToCart(AddToCart model) async {
    processing = true;
    responseBool = await CartHelper().addToCart(model);
    processing = false;

    return responseBool;
  }
}
