import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {
  final String errorText;

  ErrorTextWidget(  this.errorText) ;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errorText));
  }
}
