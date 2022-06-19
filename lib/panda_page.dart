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

class PandaPage extends StatefulWidget {
  const PandaPage({Key? key}) : super(key: key);

  @override
  State<PandaPage> createState() => _PandaPageState();
}

class _PandaPageState extends State<PandaPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          final prefs = snapshot.data as SharedPreferences;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _panda(prefs),
              TextButton(
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/button2.png",
                      fit: BoxFit.contain,
                      height: 40,
                    ),
                    Text('Feed me!',
                        style: Theme.of(context).textTheme.bodyText2),
                  ],
                  alignment: Alignment.center,
                ),
                // style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.surface),
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
                                final prefs =
                                    await SharedPreferences.getInstance();
                                final json = prefs.getString("records") ??
                                    '{"records":[]}';
                                final records =
                                    FruitRecord.fromJson(jsonDecode(json));

                                final idx = Fruit.values.indexOf(fruit);
                                records.records.add(Record(path, idx));
                                prefs.setString(
                                    "records", jsonEncode(records.toJson()));
                                Navigator.pop(context);
                                setState(() {});
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
          );
        });
  }

  // TODO: change day to day since epoch
  Widget _panda(SharedPreferences prefs) {
    final eatLastDate = DateTime.parse(StreakManager.getLastDate(prefs, "eat"));
    final now = DateTime.now();
    const pandaPath = "assets/images/panda";
    String whichPanda;

    if (eatLastDate.day == now.day) {
      whichPanda = "happy_panda.png";
    } else if (eatLastDate.day + 1 == now.day) {
      whichPanda = "normal_panda.png";
    } else {
      whichPanda = "sick_panda.png";
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Stack(
        children: [
          Image.asset("$pandaPath/platform.png", fit: BoxFit.contain),
          Image.asset("$pandaPath/$whichPanda", fit: BoxFit.contain),
        ],
      ),
    );
  }
}
