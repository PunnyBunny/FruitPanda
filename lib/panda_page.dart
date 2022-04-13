import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PandaPage extends StatelessWidget {
  const PandaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black38,
        child: Column(
          children: [
            Image.asset('assets/images/panda.png', fit: BoxFit.contain),
            ElevatedButton(
                onPressed: () async {
                  final picker = ImagePicker();
                  final photo =
                      await picker.pickImage(source: ImageSource.camera);

                  if (photo != null) {
                    final saveDir = await getApplicationDocumentsDirectory();
                    final path = saveDir.path + '/${DateTime.now()}.jpg';
                    photo.saveTo(path);
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("are you gay?"),
                        content: Image.file(File(path)),
                        actions: [
                          ElevatedButton(
                            child: const Text("yes"),
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();

                              await prefs.setStringList(
                                "records",
                                ["$path%%%0"] +
                                    (prefs.getStringList("records") ?? []),
                              );

                              Navigator.pop(context);
                            },
                          ),
                          ElevatedButton(
                            child: const Text("no"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                    // TODO: AI
                  }
                },
                child: const Text('Take a photo!')
            )
          ],
        ));
  }
}
