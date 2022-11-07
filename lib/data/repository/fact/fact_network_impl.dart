import 'dart:convert';

import 'package:test_cat_fact/constants/network_string.dart';
import 'package:test_cat_fact/data/repository/fact/fact_network.dart';

import 'package:http/http.dart' as http;

class FactNetworkImpl implements FactNetwork {
  final baseUrl = "https://catfact.ninja/facts";

  @override
  Future<List?> getListFact() async {
    var response = await http.get(Uri.parse(NetworkString().baseUrlFact));

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);

      final factsList = (json.decode(response.body)["data"]);

      return factsList;
    } else {
      return [];
    }
  }
}
