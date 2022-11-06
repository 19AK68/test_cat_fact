import 'package:test_cat_fact/data/repository/cat/cat_network.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CatNetworkImpl implements CatNetwork {
  final baseUrl = "https://cataas.com/cat?json=true";

  @override
  Future<String?> getImgCat() async {
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      String link = parsed['url'] ;

      return link; } else {
      return "";
    }

  }

}