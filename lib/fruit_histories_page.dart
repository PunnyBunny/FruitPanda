import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruit_panda/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fruit_stats_page.dart';

class FruitHistoriesPage extends StatelessWidget {
  const FruitHistoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _records(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.extent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: snapshot.data as List<Widget>,
            ),
          );
        }
        return Container();
      },
    );
  }

  Future<List<Widget>> _records(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final records = prefs.getStringList("records") ?? [];
    return records.map((String record) {
      final idx = record.indexOf(separator);
      final path = record.substring(0, idx);
      final fruit = int.parse(record.substring(idx + separator.length));
      return TextButton(
        onPressed: () =>
            pushStatisticsPage(context, Fruit.values[fruit], path: path),
        child: Column(
          children: [
            Expanded(child: Image.file(File(path), fit: BoxFit.cover)),
            Text(Fruit.values[fruit].name),
          ],
        ),
      );
    }).toList();
  }
}
