import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_app_with_node_and_mongoose/models/add_to_cart.dart';
import 'package:shoes_app_with_node_and_mongoose/services/config.dart';
import 'package:http/http.dart' as http;

import '../models/get_products.dart';

class CartHelper {
  static var client = http.Client();

  Future<bool> addToCart(AddToCart model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $userToken'
    };
    var url = Uri.http(Config.apiUrl, Config.addCartUrl);

    var response = await http.post(url,
        headers: requestHeaders, body: addToCartToJson(model));
    log('addToCart Response status code : ${response.statusCode} ');

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add to cart');
    }
  }

  Future<List<Product>> getCart() async {
    log('getCart');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $userToken'
    };
    var url = Uri.http(Config.apiUrl, Config.getCartUrl);

    var response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      log('200');
      List<Product> cart = [];

      var products = jsonData['products'];
      log(products.toString());
      cart = List<Product>.from(
          products.map((product) => Product.fromJson(product)));
      return cart;
    } else {
      throw Exception('Failed to get cart items');
    }
  }

  Future<bool> deleteItem(String id) async {
    log('delete : $id');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $userToken'
    };
    var url = Uri.http(Config.apiUrl, '${Config.deleteCartUrl}/$id');
    log(url.toString());
    var response = await http.delete(url, headers: requestHeaders);
    log('deleteItem Response status code : ${response.statusCode} ');

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete thre cart');
    }
  }
}


// {
//     "_id": "64e61cb7d91f6a95f0e5069e",
//     "userId": "64d0ee4492c0b19a11b94443",
//     "products": [
//         {
//             "cartItem": "64d0dad43964770af5927ed1",
//             "quantity": 105,
//             "_id": "64eb6eb96246ca9c49eb8dae"
//         },
//         {
//             "cartItem": "64e64620d6272bc12119e102",
//             "quantity": 1,
//             "_id": "64eb74733348713dda8783d7"
//         },
//         {
//             "cartItem": "64e64620d6272bc12119e10a",
//             "quantity": 1,
//             "_id": "64eb74ab3348713dda878655"
//         },
//         {
//             "cartItem": "64e64620d6272bc12119e132",
//             "quantity": 5,
//             "_id": "64eb74c83348713dda87865b"
//         }
//     ],
//     "createdAt": "2023-08-23T14:50:31.015Z",
//     "updatedAt": "2023-08-27T16:08:06.072Z",
//     "__v": 4
// }