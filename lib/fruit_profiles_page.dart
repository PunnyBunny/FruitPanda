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
    // final manifestContent = await rootBundle.loadString('AssetManifest.json');
    // print(manifestContent);
    // final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // final imagePaths = manifestMap.keys
    //     .where((String key) => key.contains('assets/images/fruits/'))
    //     .toList();
    // return imagePaths
    return AssetsManager.fruitImagesPath.entries
        .map((MapEntry<Fruit, String> entry) {
      Fruit fruit = entry.key;
      final fruitImagePath = entry.value;
      return TextButton(
        onPressed: () => pushStatisticsPage(context, fruit),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(width: 3.0, color: Colors.black),
          ),
          constraints: const BoxConstraints.expand(),
          child: Image.asset(fruitImagePath, fit: BoxFit.contain),
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(0),
        ),
        style: TextButton.styleFrom(
          primary: Colors.white,
          padding: const EdgeInsets.all(0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      );
    }).toList();
  }
}
