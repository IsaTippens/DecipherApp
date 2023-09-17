import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

Future<String> recogniseText(String imagePath) async {
  final inputImage = InputImage.fromFilePath(imagePath);
  final textDetector = TextRecognizer();
  final recognisedText = await textDetector.processImage(inputImage);
  textDetector.close();
  return recognisedText.text;
}
