import 'package:test_cat_fact/model/error_model.dart';
import 'package:test_cat_fact/model/fact_model.dart';

class HomePageStates {
  HomePageStates();

  factory HomePageStates.setFactList(List? list, ) =
  HomePageFactListState;
  factory HomePageStates.error(ErrorModel errorModel) = HomePageErrorState;

}

class HomePageFactListState extends HomePageStates{
  final List? list;
  HomePageFactListState(this.list);
}

class HomePageErrorState extends HomePageStates {
  final ErrorModel error;

  HomePageErrorState(this.error);
}