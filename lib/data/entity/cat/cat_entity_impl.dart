import 'package:test_cat_fact/data/entity/cat/cat_entity.dart';
import 'package:test_cat_fact/data/repository/cat/cat_network.dart';
import 'package:test_cat_fact/data/repository/cat/cat_network_impl.dart';

class CatEntityImpl implements CatEntity {
  CatNetwork catNetwork = CatNetworkImpl();
  String? link;
  @override
  Future<String?> getImgCat() async {
   return await  catNetwork.getImgCat().then((value)=> link = value);
  }
}