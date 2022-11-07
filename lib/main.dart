import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_cat_fact/constants/ui_string.dart';
import 'package:test_cat_fact/model/db/history_model.dart';

import 'package:test_cat_fact/ui/main_screen/main_screen.dart';

import 'package:test_cat_fact/utils/themes/my_themes.dart';

import 'utils/themes/custom_themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryModelAdapter());
  await Hive.openBox<HistoryModel>("history");
  runApp(const CustomTheme(
    initialThemeKey: MyThemeKeys.LIGHT,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: UiString.appBarTitle,
      theme: CustomTheme.of(context),
      home: const MainScreen(),
    );
  }
}
