import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FruitHistoriesPage extends StatelessWidget {
  const FruitHistoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _records(),
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

  Future<List<Widget>> _records() async {
    final prefs = await SharedPreferences.getInstance();
    final records = prefs.getStringList("records") ?? [];
    return records.map((String record) {
      final idx = record.indexOf('%%%');
      final path = record.substring(0, idx);
      final fruit = record.substring(idx + 3);
      print(path);
      return TextButton(
        onPressed: null,
        child: Column(
          children: [
            Expanded(child: Image.file(File(path), fit: BoxFit.cover)),
            Text(fruit),
          ],
        ),
      );
    }).toList();
  }
}
