import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fruit_panda/constants.dart';
import 'package:fruit_panda/fruit_stats_page.dart';
import 'package:fruit_panda/utils.dart';
import 'package:share_extend/share_extend.dart';

class FruitSharePage extends StatelessWidget {
  final String photoPath;
  final Fruit fruit;

  const FruitSharePage(this.photoPath, this.fruit, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eatenTime = photoPath.substring(
      photoPath.lastIndexOf('/') + 1,
      photoPath.lastIndexOf('.', photoPath.length - 5),
    );

    return WithBackground(
      child: Scaffold(
        appBar: AppBar(
          title: Text(fruit.properName),
        ),
        floatingActionButton: TextButton(
          child: Stack(
            children: [
              Image.asset("assets/images/button_cyan.png", height: 50),
              Icon(
                FontAwesomeIcons.question,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ],
            alignment: Alignment.center,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FruitStatisticsPage(fruit),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.file(File(photoPath)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Eaten at $eatenTime"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: Stack(
                  children: [
                    Image.asset("assets/images/button2.png", height: 50),
                    Text(
                      "Share it!",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ],
                  alignment: Alignment.center,
                ),
                onPressed: () {
                  ShareExtend.share(photoPath, "image");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
