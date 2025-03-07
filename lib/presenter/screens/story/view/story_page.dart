import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/model/home/word_pair_model.dart';
import 'package:language_learning/presenter/screens/story/view/story_body.dart';

import '../cubit/story_cubit.dart';

class StoryPage extends StatelessWidget {
  final List<WordPairModel> selectedWords;
  final String prompt;

  const StoryPage({
    super.key,
    required this.selectedWords,
    required this.prompt,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoryCubit()..generateStory(selectedWords, prompt),
      child: Scaffold(
        appBar: AppBar(title: const Text('Generated Story')),
        body: const StoryBody(),
      ),
    );
  }
}

