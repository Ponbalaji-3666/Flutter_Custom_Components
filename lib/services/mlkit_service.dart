import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class MlkitService{
  Future<String> ocr(InputImage inputImage) async {
    final textRecognizer = TextRecognizer();

    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    String extractedText = '';

    for (TextBlock block in recognizedText.blocks) {
      // final Rect rect = block.boundingBox;
      // final List<Point<int>> cornerPoints = block.cornerPoints;
      // final String text = block.text;
      // final List<String> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          extractedText += '${element.text} ';
        }
      }
    }

    textRecognizer.close();

    return extractedText.trim();
  }

}