import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/model/home/word_pair_model.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:dio/dio.dart';

class StoryCubit extends Cubit<BaseState> {
  StoryCubit() : super(InitialState());

  final Dio _dio = Dio();
  static const String apiKey = 'AIzaSyD5g-4UPoOTjlew0EdBsL52KB5io3Nuqo0';
  static const String endpoint =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey';

  Future<void> generateStory(List<WordPairModel> selectedWords, String userPrompt) async {
    emit(LoadingState());

    final wordsWithTranslations = selectedWords
        .map((word) => '(${word.translation})')
        .join(', ');

    final prompt = '''
You are a language learning assistant helping students improve their language skills. Your task is to write a **short, coherent, and meaningful story** using the following vocabulary words, along with their translations:


### Requirements:
- The story must be written based on **$userPrompt**.
- Use the target words naturally within the story, in a way that helps learners understand how to use them in context.
- Ensure the story is **easy to understand** and matches the given userPrompt.
- Write the story in clear, natural sentences.
- Length: 100 to 150 words.
- The story must have a **clear beginning, middle, and end**.
- Use proper grammar, and ensure it reads like something a learner would encounter in a language learning textbook.
- Use the vocabulary words at least once, but do not force them unnaturally.
- Focus on daily life situations, familiar settings, and real-world scenarios that learners can relate to.

### Example Structure (for reference):
- Introduce a character or setting.
- Present a small problem, event, or situation.
- Use the vocabulary words naturally within the situation.
- Conclude with a simple resolution.

### Example Words:
- "cat" (кот)
- "house" (дом)
- "eat" (есть)

### Example Output (for Beginner):
Masha has a cat named Murka. Murka lives in a small house with Masha. Every morning, Murka eats her food by the window. Masha loves to watch her cat eat. One day, Murka finds a toy under the table and plays with it happily. Masha smiles, and they both enjoy a sunny afternoon together.

### Now, write the story using these words:
$wordsWithTranslations

### Output Format:
Just the story text, no extra explanation or introduction.
''';

    final requestBody = {
      "contents": [
        {
          "parts": [
            {"text": prompt}
          ]
        }
      ]
    };

    try {
      final response = await _dio.post(
        endpoint,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: requestBody,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final story = data['candidates']?[0]['content']['parts']?[0]['text'] ?? 'No story found.';
        emit(SuccessState(data: story));
      } else {
        print('failed to generate story');
      }
    } catch (e) {
      print('error');
    }
  }
}

