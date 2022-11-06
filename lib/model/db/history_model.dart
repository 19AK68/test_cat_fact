import 'package:hive/hive.dart';
part 'history_model.g.dart';
@HiveType(typeId: 0)
class HistoryModel extends HiveObject {
  @HiveField(0)
  late DateTime createdDate;
  @HiveField(1)
  late String fact;
}