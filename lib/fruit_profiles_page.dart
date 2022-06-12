import 'package:flutter/material.dart';
import 'package:fruit_panda/fruit_stats_page.dart';
import 'package:fruit_panda/utils.dart';

import 'constants.dart';

class FruitProfilesPage extends StatelessWidget {
  const FruitProfilesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fruits(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            color: Colors.white,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: snapshot.data as List<Widget>,
            ),
            padding: const EdgeInsets.all(8),
          );
        }
        return Container();
      },
    );
  }

  Future<List<Widget>> _fruits(BuildContext context) async {
    return AssetsManager.fruitImagesPath.entries
        .map((MapEntry<Fruit, String> entry) {
      Fruit fruit = entry.key;
      final fruitImagePath = entry.value;
      return ElevatedButton(
        onPressed: () => pushStatisticsPage(context, fruit),
        child: Image.asset(fruitImagePath, fit: BoxFit.contain),
      );
    }).toList();
  }
}
