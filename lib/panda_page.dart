import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruit_panda/ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fruits.dart';

class PandaPage extends StatelessWidget {
  const PandaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      child: Column(
        children: [
          Image.asset('assets/images/panda.png', height: 500, fit: BoxFit.contain),
          ElevatedButton(
            child: const Text('Feed me!'),
            onPressed: () async {
              final picker = ImagePicker();
              final photo = await picker.pickImage(
                source: ImageSource.camera,
                maxHeight: 800,
              );

              if (photo == null) return;

              // save the picture
              final saveDir = await getApplicationDocumentsDirectory();
              final path = saveDir.path + '/${DateTime.now()}.jpg';
              photo.saveTo(path);

              final fruits = inference(path);

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => FutureBuilder(
                  future: fruits,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
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

                    final fruit = snapshot.data as Fruits;
                    if (fruit == Fruits.none) {
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

                    return AlertDialog(
                      title: Text("Is this ${fruit.name}?"),
                      content: Image.file(File(path)),
                      actions: [
                        ElevatedButton(
                          child: const Text("Yes"),
                          onPressed: () async {
                            // add record to shared preferences
                            final prefs = await SharedPreferences.getInstance();

                            await prefs.setStringList(
                              "records",
                              ["$path%%%0"] +
                                  (prefs.getStringList("records") ?? []),
                            );

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
