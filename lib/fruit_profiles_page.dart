import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            child: GridView.extent(
              maxCrossAxisExtent: 200,
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
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('assets/images/fruits/'))
        .toList();
    return imagePaths
        .map(
          (String path) => TextButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Sure?"),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Yes'),
                  ),
                ],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                border: Border.all(width: 3.0, color: Colors.black),
              ),
              child: Image.asset(path),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(0),
            ),
            style: TextButton.styleFrom(
              primary: Colors.white,
              padding: const EdgeInsets.all(0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        )
        .toList();
  }
}
