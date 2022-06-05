import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fruit_panda/constants.dart';

class AssetsManager {
  var imagesPath = <String, String>{};
  var fruitImagesPath = <Fruit, String>{};
  void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final imagePaths = manifestMap.keys;
    for(String path in imagePaths) {
      final imageName = path.substring(path.lastIndexOf('/') + 1, path.lastIndexOf('.'));
      if(path.contains('fruits')) {
        fruitImagesPath[asFruit(imageName)] = path;
      } else {
        imagesPath[imageName] = path;
      }
    }
  }
}

Fruit asFruit(String str)
{
  for(Fruit f in Fruit.values){
    if(str == f.name) {
      return f;
    }
  }
  return Fruit.unknown;
}