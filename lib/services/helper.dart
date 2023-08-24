import 'dart:developer';

import 'package:shoes_app_with_node_and_mongoose/services/config.dart';

import '../models/sneaker_model.dart';
import 'package:http/http.dart' as http;

// this class fetches data from the json file and return it to the app
class Helper {
  static var client = http.Client();
  // Male
  Future<List<Sneakers>> getMaleSneakers() async {
    var url = Uri.http(Config.apiUrl, Config.sneakers);

    var response = await client.get(url);

    if (response.statusCode == 200) {
      final sneakersList = sneakersFromJson(response.body);
      var male =
          sneakersList.where((element) => element.category == "Men's Running");
      return male.toList();
    } else {
      throw Exception('Failed to get sneakers list');
    }
  }

// Female
  Future<List<Sneakers>> getFemaleSneakers() async {
    var url = Uri.http(Config.apiUrl, Config.sneakers);

    var response = await client.get(url);

    if (response.statusCode == 200) {
      final sneakersList = sneakersFromJson(response.body);
      var female = sneakersList
          .where((element) => element.category == "Women's Running");
      return female.toList();
    } else {
      throw Exception('Failed to get sneakers list');
    }
  }

// Kids
  Future<List<Sneakers>> getKidsSneakers() async {
    log('getKidsSneakers');
    var url = Uri.http(Config.apiUrl, Config.sneakers);

    var response = await client.get(url);

    if (response.statusCode == 200) {
      final sneakersList = sneakersFromJson(response.body);

      var kid =
          sneakersList.where((element) => element.category == "Kid's Running");
      log(kid.toList().toString());
      return kid.toList();
    } else {
      throw Exception('Failed to get sneakers list');
    }
  }

  Future<List<Sneakers>> search(String searchQuery) async {
    var url = Uri.http(Config.apiUrl, "${Config.search}$searchQuery");

    var response = await client.get(url);

    if (response.statusCode == 200) {
      final results = sneakersFromJson(response.body);

      return results;
    } else {
      throw Exception('Failed to get sneakers list');
    }
  }
}
