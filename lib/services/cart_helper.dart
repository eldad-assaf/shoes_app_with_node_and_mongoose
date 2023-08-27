import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_app_with_node_and_mongoose/models/add_to_cart.dart';
import 'package:shoes_app_with_node_and_mongoose/services/config.dart';
import 'package:http/http.dart' as http;

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

    if (response.statusCode == 200) {
      // var profile = profileResFromJson(response.body);
      // return profile;
      return true;
    } else {
      throw Exception('Failed to add to cart');
    }
  }
}
