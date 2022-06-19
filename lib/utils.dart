import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruit_panda/constants.dart';

class AssetsManager {
  static var imagesPath = <String, String>{};
  static var fruitImagesPath = <Fruit, String>{};

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final imagePaths = manifestMap.keys;
    for (String path in imagePaths) {
      final imageName =
          path.substring(path.lastIndexOf('/') + 1, path.lastIndexOf('.'));
      if (path.contains('orangeblack')) {
        fruitImagesPath[asFruit(imageName)] = path;
      } else {
        imagesPath[imageName] = path;
      }
    }
  }
}

Fruit asFruit(String fruit) {
  return Fruit.values.firstWhere(
    (e) => e.name == fruit,
    orElse: () => Fruit.unknown,
  );
}

class WithBackground extends StatelessWidget {
  final Widget? child;
  const WithBackground({this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (child != null) child!,
      ],
    );
  }
}

