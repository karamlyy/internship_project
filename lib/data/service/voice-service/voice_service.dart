import 'package:flutter_tts/flutter_tts.dart';

class VoiceService {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> _initializeTTS() async {
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
  }

  Future<void> speak(String text) async {
    await _initializeTTS();
    await flutterTts.speak(text);
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }
}
