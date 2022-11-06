import 'package:test_cat_fact/model/fact_model.dart';

abstract class FactEntity{
  Future<List?> getListFact();
}