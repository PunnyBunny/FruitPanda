import 'package:fruit_panda/fruits.dart';
import 'package:tflite/tflite.dart';

Future loadModel(String modelPath, String labelsPath) async {
  Tflite.close();
  await Tflite.loadModel(model: modelPath, labels: labelsPath);
}

Future<Fruits> inference(String path) async {
  print("infering");
  print(path);
  final recognitions = await Tflite.detectObjectOnImage(
    path: path,
    model: "YOLO",
    imageMean: 0,
    imageStd: 255.0,
    numResultsPerClass: 1,
    threshold: 0.2,
  );

  print(recognitions);
  if (recognitions == null) return Fruits.none;
  for (final i in recognitions) {
    for (Fruits j in Fruits.values) {
      if (i['detectedClass'] == j.name) return j;
    }
  }
  return Fruits.none;
}

Future closeModel() async {
  await Tflite.close();
}