import 'dart:async';

import 'package:test_cat_fact/data/entity/fact/fact_entity.dart';
import 'package:test_cat_fact/data/entity/fact/fact_entity_impl.dart';
import 'package:test_cat_fact/model/fact_model.dart';
import 'package:test_cat_fact/ui/home_page/home_page_state.dart';

class HomePageBlock {
  final _factStreamController = StreamController<HomePageStates>.broadcast();

  Stream<HomePageStates> get streamListFact => _factStreamController.stream;

  late FactEntity _factEntity;
  List? listFact;

  HomePageBlock() {
    _factEntity = FactEntityImpl();
  }

  Future<void> initState() async {
    getFact();
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
      //   setDailyTitleOnScreen(true);
      //    setDailyNameOnScreen(dailyRecipe![0].postTitle);
    });

    //  print('Fact ; $gf');
  }

  String? currentDate(){
    DateTime now = DateTime.now();
    return now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString();
  }

  void dispose() {
    _factStreamController.close();
  }
}
