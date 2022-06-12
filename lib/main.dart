import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruit_panda/ai.dart';
import 'package:fruit_panda/streak_manager.dart';
import 'package:fruit_panda/utils.dart';

import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await loadModel(
      "assets/models/yolov2_tiny.tflite", "assets/models/yolov2_tiny.txt");
  await AssetsManager.init();
  await StreakManager.perform("login");
  // await loadModel("assets/models/yolov3-416.tflite", "assets/models/labels.txt");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruit Panda',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
        ),
        primarySwatch: Colors.orange,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.orange[200],
            padding: const EdgeInsets.all(16),
            elevation: 8,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
