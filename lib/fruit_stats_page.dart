import 'package:flutter/material.dart';
import 'package:fruit_panda/constants.dart';
import 'package:fruit_panda/main.dart';

void pushStatisticsPage(BuildContext context, Fruit fruit, {String? path}) {
  // print(path);
  Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(title: Text(fruit.name)),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(assetsManager.fruitImagesPath[fruit]!),
                      if(path != null) Text('Eaten at ${path.substring(
                        path.lastIndexOf('/') + 1, path.lastIndexOf('.', path.length - 5)
                      )}'),
                    ],
                  )
                ),
              )
            );
          }
      )
  );
}