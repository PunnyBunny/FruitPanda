import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
      if (path.contains('fruits')) {
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
