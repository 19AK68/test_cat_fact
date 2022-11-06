import 'dart:async';

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
    var dates = now.day.toString() + now.month.toString() + now.year.toString();
    return "\n${now.day}/ ${now.month}/${now.year}\n ${now.hour}:${now.minute}:${now.second}";
  }

  String randomImg() {
    String urlCat = "https://cataas.com/$linkImgCat";
    return urlCat;
  }

  void dispose() {
    _factStreamController.close();
  }
}
