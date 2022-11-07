import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:test_cat_fact/constants/ui_constans.dart';
import 'package:test_cat_fact/constants/ui_string.dart';
import 'package:test_cat_fact/model/db/history_model.dart';
import 'package:test_cat_fact/utils/db_utils/boxes.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<HistoryModel> histories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UiString.titleHistoryPage),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<HistoryModel>>(
        valueListenable: Boxes.getHistories().listenable(),
        builder: (context, box, _) {
          final histories = box.values.toList().cast<HistoryModel>();

          return buildContent(histories);
        },
      ),
    );
  }

  Widget buildContent(List<HistoryModel> histories) {
    if (histories.isEmpty) {
      return const Center(
        child: Text(
          'No expenses yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: histories.length,
              itemBuilder: (BuildContext context, int index) {
                final history = histories[index];

                return buildHistories(context, history);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildHistories(BuildContext context, HistoryModel history) {
    final date = DateFormat.yMMMd().format(history.createdDate);
    final catFact = history.fact.toString();
    return Card(
      child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          title: Text(date),
          subtitle: Text(
            catFact,
            maxLines: 4,
            style: TextStyle(
                color: UiConstants.colorsTextFact,
                fontWeight: FontWeight.bold,
                fontSize: UiConstants.fontSizeExpansionTitle),
          ),
          children: [
            buildButtons(context, history),
          ]),
    );
  }

  buildButtons(BuildContext context, HistoryModel history) {
    return Row(
      children: [
        Expanded(
          child: TextButton.icon(
            label: Text(UiString.buttonDeleteText),
            icon: const Icon(Icons.delete),
            onPressed: () {
              history.delete();
            },
          ),
        ),
      ],
    );
  }
}
