import 'package:flutter/material.dart';
import 'package:test_cat_fact/constants/ui_string.dart';
import 'package:test_cat_fact/ui/home_page/home_page.dart';
import 'package:test_cat_fact/ui/main_screen/main_screen.dart';

import 'package:test_cat_fact/utils/themes/my_themes.dart';

import 'utils/themes/custom_themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: const MainScreen(), //HomePage(title: UiString.titelHopmePage),
    );
  }
}
