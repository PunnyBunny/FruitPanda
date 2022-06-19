import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruit_panda/constants.dart';
import 'package:fruit_panda/logger.dart';
import 'package:fruit_panda/utils.dart';

class FruitStatisticsPage extends StatelessWidget {
  final Fruit fruit;
  final String? path;

  const FruitStatisticsPage(this.fruit, {Key? key, this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fruitStatisticsPage(context, fruit, path: path),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data as Widget;
        }
        return Container();
      },
    );
  }
}

Future<Widget> _fruitStatisticsPage(BuildContext context, Fruit fruit,
    {String? path}) async {
  logger.i(await getNutrition(fruit));

  final eatenTime = path?.substring(
    path.lastIndexOf('/') + 1,
    path.lastIndexOf('.', path.length - 5),
  );

  return WithBackground(
    child: Scaffold(
      appBar: AppBar(title: Text(fruit.properName)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AssetsManager.fruitImagesPath[fruit]!, height: 500),

              // path : */*/date time.milliseconds.jpg
              if (eatenTime != null) Text('Eaten at $eatenTime'),

              ...(await getNutrition(fruit)).map((line) => Text(line)),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<List<String>> getNutrition(Fruit fruit) async {
  final jsonString = await rootBundle.loadString("assets/nutrition.json");
  final nutritionDict = json.decode(jsonString);
  List<String> nutritionList = [];
  for (final entry in nutritionDict[fruit.properName]!.entries) {
    nutritionList.add(entry.key + ": " + entry.value.toStringAsFixed(2));
  }
  return nutritionList;
}

void pushStatisticsPage(BuildContext context, Fruit fruit, {String? path}) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FruitStatisticsPage(fruit, path: path)));
}
