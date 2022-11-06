import 'dart:async';
import 'dart:math';

import 'package:test_cat_fact/data/entity/cat/cat_entity.dart';
import 'package:test_cat_fact/data/entity/cat/cat_entity_impl.dart';
import 'package:test_cat_fact/data/entity/fact/fact_entity.dart';
import 'package:test_cat_fact/data/entity/fact/fact_entity_impl.dart';

import 'package:test_cat_fact/ui/home_page/home_page_state.dart';

class HomePageBlock {
  final _factStreamController = StreamController<HomePageStates>.broadcast();

  Stream<HomePageStates> get streamListFact => _factStreamController.stream;

  late FactEntity _factEntity;
  late CatEntity _catEntity;
  List? listFact;
  String? linkImgCat;

  String? _stringDate;

  String get stringData => _stringDate!;
  DateTime? _dateTimes;

  DateTime get dateTimes => _dateTimes!;
  String? _fact;

  set fact(String value) {
    _fact = value;
  }

  String get fact => _fact!;

  HomePageBlock() {
    _factEntity = FactEntityImpl();
    _catEntity = CatEntityImpl();
  }

  Future<void> initState() async {
    getFact();
    getCat();
  }

  Future<void> getFact() async {
    var gf;
    _factEntity.getListFact().then((list) {
      listFact = list;
      //    gf = listFact![0]!["fact"]!.toString();

      if (!_factStreamController.isClosed) {
        _factStreamController.sink.add(HomePageStates.setFactList(
          listFact!,
        ));
      }
    });
  }

  Future<void> getCat() async {
    _catEntity.getImgCat().then((value) {
      linkImgCat = value;
    });
    randomImg();
  }

  String? currentDate() {
    DateTime now = DateTime.now();
    _dateTimes = now;
    _stringDate =
        "\n${now.day}/ ${now.month}/${now.year} ${now.hour}:${now.minute}:${now.second}\n";
    return _stringDate;
  }

  String? currentFact() {
    final random = Random();
    var randomItem = random.nextInt(listFact!.length);
    //  var text = list[randomItem]["fact"].toString();
    _fact = listFact![randomItem]["fact"].toString();
    return _fact;
  }

  String randomImg() {
    String urlCat = "https://cataas.com/$linkImgCat";
    return urlCat;
  }

  void dispose() {
    _factStreamController.close();
  }
}
