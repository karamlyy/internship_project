import 'package:flutter/material.dart';
import 'package:language_learning/presenter/screens/word-list/provider/word_list_provider.dart';
import 'package:provider/provider.dart';

class WordListMain extends StatelessWidget {
  const WordListMain({super.key});

  @override
  Widget build(BuildContext context) {
    final wordListProvider = context.watch<WordListProvider>();

    return Center(child: Expanded(child: Text('CATEGORY WORDS')));
  }
}
