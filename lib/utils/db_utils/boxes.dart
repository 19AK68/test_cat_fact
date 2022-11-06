import 'package:hive/hive.dart';
import 'package:test_cat_fact/model/db/history_model.dart';

class Boxes {
  static Box<HistoryModel> getHistories()  => Hive.box("history");
}