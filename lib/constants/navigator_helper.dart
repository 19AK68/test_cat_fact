import 'package:flutter/material.dart';
import 'package:test_cat_fact/ui/history_page/history_page.dart';

class NavigationHelper {
  static void openHistoryPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryPage()));
  }
}
