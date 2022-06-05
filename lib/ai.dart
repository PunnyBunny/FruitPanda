import 'package:fruit_panda/constants.dart';
import 'package:fruit_panda/utils.dart';
import 'package:tflite/tflite.dart';

import 'logger.dart';

Future loadModel(String modelPath, String labelsPath) async {
  Tflite.close();
  await Tflite.loadModel(model: modelPath, labels: labelsPath);
}

Future<Fruit> inference(String path) async {
  final recognitions = await Tflite.detectObjectOnImage(
    path: path,
    model: "YOLO",
    imageMean: 0,
    imageStd: 255.0,
    numResultsPerClass: 1,
    threshold: 0.2,
  );

  logger.i(recognitions);
  if (recognitions == null) return Fruit.unknown;
  for (final i in recognitions) {
    Fruit f = asFruit(i['detectedClass']);
    if (f != Fruit.unknown) return f;
  }
  return Fruit.unknown;
}

Future closeModel() async {
  await Tflite.close();
}
