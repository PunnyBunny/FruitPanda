import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruit_panda/constants.dart';
import 'package:fruit_panda/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fruit_record.dart';
import 'fruit_share_page.dart';

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
            child: GridView.count(
              crossAxisCount: 2,
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
        child: TextButton(
          child: Stack(
            children: [
              Image.asset("assets/images/button.png"),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(offset: Offset(2, 2), blurRadius: 3),
                          ],
                        ),
                        child: Image.file(
                          File(record.path),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        Fruit.values[record.fruit].properName,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            alignment: Alignment.center,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FruitSharePage(
                record.path,
                Fruit.values[record.fruit],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
