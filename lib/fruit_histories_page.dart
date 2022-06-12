import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruit_panda/constants.dart';
import 'package:fruit_panda/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fruit_record.dart';
import 'fruit_stats_page.dart';

class FruitHistoriesPage extends StatelessWidget {
  const FruitHistoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _records(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final records = snapshot.data as List<Widget>;
          if (records.isEmpty) {
            return Center(
              child: Text(
                "Eat your first fruit to get started!",
                style: Theme.of(context).textTheme.headline5,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.extent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: records,
            ),
          );
        }
        return Container();
      },
    );
  }

  Future<List<Widget>> _records(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString("records") ?? '{"records":[]}';
    final records = FruitRecord.fromJson(jsonDecode(json));
    return records.records.map((Record record) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => pushStatisticsPage(
            context,
            Fruit.values[record.fruit],
            path: record.path,
          ),
          child: Column(
            children: [
              Expanded(child: Image.file(File(record.path), fit: BoxFit.cover)),
              Text(Fruit.values[record.fruit].name),
            ],
          ),
        ),
      );
    }).toList();
  }
}
