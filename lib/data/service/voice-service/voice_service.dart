import 'package:flutter_tts/flutter_tts.dart';

class VoiceService {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> _initializeTTS() async {
    try {
      await flutterTts.awaitSpeakCompletion(true);
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.5);
    } catch (e) {
      print("TTS Initialization Error: $e");
    }
  }

  Future<void> speak(String text) async {   // <-- Add this public method
    try {
      await _initializeTTS();
      await flutterTts.speak(text);
    } catch (e) {
      print("Error in TTS: $e");
    }
  }
}