import 'package:test_cat_fact/data/entity/fact/fact_entity.dart';
import 'package:test_cat_fact/data/repository/fact/fact_network.dart';
import 'package:test_cat_fact/data/repository/fact/fact_network_impl.dart';
import 'package:test_cat_fact/model/fact_model.dart';

class FactEntityImpl implements FactEntity {
  FactNetwork _factNetwork = FactNetworkImpl();
  List? list;
  @override
  Future<List?> getListFact() async {
    return await _factNetwork.getListFact().then((value) => list =value);
  }
}