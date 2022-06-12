import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruit_panda/ai.dart';
import 'package:fruit_panda/fruit_record.dart';
import 'package:fruit_panda/record.dart';
import 'package:fruit_panda/streak_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class PandaPage extends StatelessWidget {
  const PandaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      child: Column(
        children: [
          Image.asset(
            'assets/images/panda2.png',
            height: 500,
            fit: BoxFit.contain,
          ),
          ElevatedButton(
            child: const Text('Feed me!'),
            onPressed: () async {
              final picker = ImagePicker();
              final photo = await picker.pickImage(
                source: ImageSource.camera,
                maxHeight: 800,
              );

              if (photo == null) return;

              // assuming fruit has been consumed
              StreakManager.perform("eat");

              // save the picture
              final saveDir = await getApplicationDocumentsDirectory();
              final path = '${saveDir.path}/${DateTime.now()}.jpg';
              photo.saveTo(path);

              final fruit = inference(path);

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => FutureBuilder(
                  future: fruit,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      // detecting
                      return AlertDialog(
                        title: const Text("Detecting..."),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    }

                    final fruit = snapshot.data as Fruit;
                    if (fruit == Fruit.unknown) {
                      // no fruits detected
                      return AlertDialog(
                        title: const Text("No fruits detected"),
                        content: Image.file(File(path)),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Ok"),
                          ),
                        ],
                      );
                    }

                    // fruit detected
                    return AlertDialog(
                      title: Text("Is this ${fruit.name}?"),
                      content: Image.file(File(path)),
                      actions: [
                        ElevatedButton(
                          child: const Text("Yes"),
                          onPressed: () async {
                            // add record to shared preferences
                            final prefs = await SharedPreferences.getInstance();
                            final json =
                                prefs.getString("records") ?? '{"records":[]}';
                            final records =
                                FruitRecord.fromJson(jsonDecode(json));

                            final idx = Fruit.values.indexOf(fruit);
                            records.records.add(Record(path, idx));
                            prefs.setString(
                                "records", jsonEncode(records.toJson()));
                            Navigator.pop(context);
                          },
                        ),
                        ElevatedButton(
                          child: const Text("No"),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
