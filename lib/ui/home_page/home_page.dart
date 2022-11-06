import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_cat_fact/constants/navigator_helper.dart';
import 'package:test_cat_fact/constants/ui_constans.dart';
import 'package:test_cat_fact/constants/ui_string.dart';
import 'package:test_cat_fact/model/db/history_model.dart';
import 'package:test_cat_fact/ui/home_page/home_page_block.dart';
import 'package:test_cat_fact/ui/home_page/home_page_state.dart';
import 'package:test_cat_fact/ui/widget/error_text_widget.dart';
import 'package:test_cat_fact/ui/widget/loading_widget.dart';
import 'package:test_cat_fact/utils/db_utils/boxes.dart';
import 'package:test_cat_fact/utils/themes/custom_themes.dart';
import 'package:test_cat_fact/utils/themes/my_themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLightThemColor = false;
  late HomePageBlock _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = HomePageBlock();
    _bloc.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text(
          widget.title,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () {
              setState(() {
                _isLightThemColor
                    ? CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.DARK)
                    : CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.LIGHT);
                _isLightThemColor = !_isLightThemColor;
              });
            },
          ),
        ],
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 20),
        Text(
          UiString.randomTextHomePage,
          style: TextStyle(
              color: UiConstants.colorsTextFact,
              fontWeight: FontWeight.bold,
              fontSize: UiConstants.randomTextHomePageFonSize),
        ),
        const SizedBox(height: 20),
        Expanded(child: randomFactStreamWidget()),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
                height: UiConstants.buttonHeight,
                width: UiConstants.buttonWidth,
                child: buildButtonSave()),
            SizedBox(
              height: UiConstants.buttonHeight,
              width: UiConstants.buttonWidth,
              child: MaterialButton(
                  onPressed: () {
                    _bloc.getFact();
                    _bloc.getCat();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: UiConstants.colorsTextFact)),
                  child: Text(
                    UiString.buttonNextText,
                    style: TextStyle(color: UiConstants.colorsTextFact, fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        )
      ],
    );
  }

  MaterialButton buildButtonSave() {
    return MaterialButton(
        onPressed: () {
          final histories = HistoryModel()
            ..createdDate = _bloc.dateTimes
            ..fact = _bloc.fact;
          final box = Boxes.getHistories();
          box.add(histories);
          NavigationHelper.openHistoryPage(context);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: UiConstants.colorsTextFact)),
        child: Text(UiString.buttonSaveText));
  }

  Widget randomFactStreamWidget() {
    return StreamBuilder(
        stream: _bloc.streamListFact,
        builder: (BuildContext context, snapshot) {
          if (snapshot.data is HomePageFactListState) {
            HomePageFactListState state = snapshot.data as HomePageFactListState;
            return _randomFactListWidget(state.list);
          } else if (snapshot.data is HomePageErrorState) {
            HomePageErrorState state = snapshot.data as HomePageErrorState;
            return ErrorTextWidget(state.error.text);
          } else {
            if (_bloc.listFact != null) {
              return _randomFactListWidget(_bloc.listFact);
            }
            double width = MediaQuery.of(context).size.width / UiConstants.homePageWidgetWidth;
            double height = width + width / UiConstants.homePageHorizontalWidgetTitle;
            return SizedBox(height: height, child: LoadingWidget());
          }
        });
  }

  Widget _randomFactListWidget(List? list) {
    final random = Random();
    String? currentDate = _bloc.currentDate();
    if (list != null && list.isNotEmpty) {
      var randomItem = random.nextInt(list.length);
      var text = _bloc.listFact![randomItem]["fact"].toString();
      _bloc.fact = text;

      return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Center(
            child: Card(
                shadowColor: Theme.of(context).cardColor,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(UiConstants.borderRadiusCircular.toDouble()),
                ),
                // height: 200,
                // width: 200,
                // constraints: const BoxConstraints(maxHeight: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(UiConstants.borderRadiusCircular.toDouble()),
                  child: Image.network(
                    _bloc.randomImg(),
                    fit: BoxFit.cover,
                    height: UiConstants.imgCatHeight,
                    width: UiConstants.imgCatWidth,
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shadowColor: Theme.of(context).cardColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(UiConstants.borderRadiusCircular.toDouble()),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            currentDate!,
                            style: TextStyle(
                                fontSize: UiConstants.fontSizeTextFact,
                                color: UiConstants.colorsTextFact,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        _bloc.fact,
                        style: TextStyle(
                            fontSize: UiConstants.fontSizeTextFact,
                            color: UiConstants.colorsTextFact,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(height: 200);
    }
  }

  Widget bb(Null Function() press) {
    return MaterialButton(
        onPressed: press,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Theme.of(context).primaryColorLight)),
        child: Text(UiString.buttonNextText));
  }
}
