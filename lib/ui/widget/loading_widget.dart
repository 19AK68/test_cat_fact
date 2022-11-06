import "dart:math";

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_cat_fact/constants/ui_constans.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: UiConstants.loadingWIdgetSides.toDouble(),
        width: UiConstants.loadingWIdgetSides.toDouble(),
        child: spinKit,
      ),
    );
  }

  Widget spinKit = SpinKitThreeBounce(
    size: 20,
    itemBuilder: (BuildContext context, int index) {
      List<Color> list = [
        const Color(0xff171d49),
        Colors.blue,
        Colors.lightBlue,
        Colors.lightBlueAccent,
        Colors.white
      ];
      final random = Random();
      return DecoratedBox(
        decoration: BoxDecoration(
          color: list[random.nextInt(list.length)],
        ),
      );
    },
  );
}
