import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/service/voice-service/voice_service.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/story/cubit/story_cubit.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';

class StoryBody extends StatelessWidget {
  const StoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    final VoiceService voiceService = VoiceService();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<StoryCubit, BaseState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lotties/gemini.json',
                    width: 150.w,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            );
          } else if (state is FailureState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else if (state is SuccessState) {
            final story = state.data as String;
            return SingleChildScrollView(
              child: TypingText(
                text: story,
                voiceService: voiceService,
              ),
            );
          } else {
            return const Center(child: Text('No story available.'));
          }
        },
      ),
    );
  }
}

class TypingText extends StatelessWidget {
  final String text;
  final int speedMilliseconds;
  final VoiceService voiceService;

  const TypingText({
    super.key,
    required this.text,
    this.speedMilliseconds = 40,
    required this.voiceService,
  });

  Stream<String> _characterStream(String text) async* {
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      await Future.delayed(Duration(milliseconds: speedMilliseconds));
      yield buffer.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        voiceService.stop();
        return true;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.volume_up),
                onPressed: () {
                  voiceService.speak(text);
                },
              ),
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: text));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Text copied to clipboard!')),
                  );
                },
              ),
            ],
          ),
          StreamBuilder<String>(
            stream: _characterStream(text),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                child: Text(
                  snapshot.data ?? '',
                  style: const TextStyle(fontSize: 16.0),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
