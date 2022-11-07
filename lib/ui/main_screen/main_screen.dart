import 'package:flutter/material.dart';
import 'package:test_cat_fact/constants/ui_constans.dart';
import 'package:test_cat_fact/constants/ui_string.dart';
import 'package:test_cat_fact/ui/history_page/history_page.dart';
import 'package:test_cat_fact/ui/home_page/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Widget> _widgetOptions;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomePage(title: UiString.titleHomePage),
      const HistoryPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Theme.of(context).backgroundColor,
        selectedItemColor: Theme.of(context).primaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: UiConstants.sizeBottomNavigationBarItem,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history_edu_sharp,
              size: UiConstants.sizeBottomNavigationBarItem,
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
