import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruit_panda/ai.dart';
import 'package:fruit_panda/streak_manager.dart';
import 'package:fruit_panda/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

/*
 *  TODO: notification
 *  TODO: fix fruit bug
 *  TODO: fix AI
*/
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
          backgroundColor: Color(0xFF241C10),
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.transparent,
        // colorScheme: ColorScheme.fromSwatch(
        //   primarySwatch: Colors.orange,
        //   accentColor: Colors.cyanAccent,
        //   brightness: Brightness.dark,
        // ),
        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF241C10),
          primary: Color(0xFFBC8A51),
          primaryContainer: Color(0xFF6B4E2E), // less bright
          secondary: Color(0xFF00FFFA),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(8),
            elevation: 16,
          ),
        ),
        textTheme: GoogleFonts.latoTextTheme(
          Typography.whiteMountainView.copyWith(
            headline6: const TextStyle(letterSpacing: 0.7),
            bodyText2: const TextStyle(letterSpacing: 0.3),
          ),
        ),
        applyElevationOverlayColor: true,
      ),
      home: const HomePage(),
    );
  }
}
