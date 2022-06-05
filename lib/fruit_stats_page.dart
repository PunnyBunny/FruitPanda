import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruit_panda/constants.dart';
import 'package:fruit_panda/main.dart';

class FruitStatisticsPage extends StatelessWidget {
  Fruit fruit;
  String? path;
  FruitStatisticsPage(this.fruit, {Key? key, this.path }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fruitStatisticsPage(context, fruit, path:path),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return snapshot.data as Widget;
        }
        return Container();
      },
    );
  }
}

Future<Widget> _fruitStatisticsPage(BuildContext context, Fruit fruit, {String? path}) async {
  getNutrition(fruit).then((res) {print(res);});
  return Scaffold(
      appBar: AppBar(title: Text(fruit.properName)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(assetsManager.fruitImagesPath[fruit]!),
                if(path != null) Text('Eaten at ${path.substring(
                  // path : */*/date time.milliseconds.jpg
                    path.lastIndexOf('/') + 1, path.lastIndexOf('.', path.length - 5)
                )}'),
                ...(await getNutrition(fruit).then((res) {
                  List<Widget> textList = [];
                  for(String nutritionLine in res) {
                    textList.add(Text(nutritionLine));
                  }
                  return textList;
                }))
              ],
            )
        ),
      )
  );
}

Future<List<String>> getNutrition(Fruit fruit) async {
  final jsonString = await rootBundle.loadString("assets/nutrition.json");
  final nutritionDict = json.decode(jsonString);
  List<String> nutritionList = [];
  for(final entry in nutritionDict[fruit.properName]!.entries){
    nutritionList.add(entry.key +": "+ entry.value.toStringAsFixed(2));
  }
  // print(nutritionList);
  return nutritionList;
}


void pushStatisticsPage(BuildContext context, Fruit fruit, {String? path}) {
  // print(path);
  Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => FruitStatisticsPage(fruit, path:path)
      )
  );
}