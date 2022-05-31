import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruit_panda/ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'fruits.dart';

class PandaPage extends StatelessWidget {
  const PandaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      child: Column(
        children: [
          Image.asset('assets/images/panda.png', height: 500),
          ElevatedButton(
            child: const Text('Take a photo!'),
            onPressed: () async {
              final picker = ImagePicker();
              final photo = await picker.pickImage(source: ImageSource.camera);

              if (photo == null) return;

              // save the picture
              final saveDir = await getApplicationDocumentsDirectory();
              final path = saveDir.path + '/${DateTime.now()}.jpg';
              photo.saveTo(path);

              final fruits = inference(path);

              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: FutureBuilder(
                    future: fruits,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Text("Detecting...");
                      }
                      final fruits = snapshot.data as Fruits;
                      if (fruits == Fruits.none) {
                        return const Text("No fruits detected");
                      }
                      return Text("Is this ${fruits.name}");
                    },
                  ),
                  content: FutureBuilder(
                    future: fruits,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            CircularProgressIndicator(strokeWidth: 5),
                          ],
                        );
                      }
                      // final fruits = snapshot.data as Fruits?;
                      return Image.file(File(path));
                    },
                  ),
                ),
              );
              // FutureBuilder(future: inference(path), builder: () => {});
              //
              // final fruits = await inference(path);
              //
              // if (fruits == null) {
              //   showDialog(
              //     context: context,
              //     builder: (_) => AlertDialog(
              //       title: const Text("No fruits detected"),
              //       content: Image.file(File(path)),
              //       actions: [
              //         ElevatedButton(
              //           child: const Text("OK"),
              //           onPressed: () => Navigator.pop(context),
              //         ),
              //       ],
              //     ),
              //   );
              // } else {
              //   showDialog(
              //     context: context,
              //     builder: (_) => AlertDialog(
              //       title: Text("Is this ${fruits.name}?"),
              //       content: Image.file(File(path)),
              //       actions: [
              //         ElevatedButton(
              //           child: const Text("Yes"),
              //           onPressed: () async {
              //             // add record to shared preferences
              //             final prefs = await SharedPreferences.getInstance();
              //
              //             await prefs.setStringList(
              //               "records",
              //               ["$path%%%apple"] +
              //                   (prefs.getStringList("records") ?? []),
              //             );
              //
              //             Navigator.pop(context);
              //           },
              //         ),
              //         ElevatedButton(
              //           child: const Text("No"),
              //           onPressed: () => Navigator.pop(context),
              //         ),
              //       ],
              //     ),
              //   );
              // },
            },
          ),
        ],
      ),
    );
  }
}
