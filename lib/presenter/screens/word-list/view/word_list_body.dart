import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_learning/presenter/screens/word-list/view/word_list_main.dart';
import 'package:language_learning/presenter/widgets/primary_appbar.dart';

class WordListBody extends StatelessWidget {
  const WordListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          WordListMain(),
        ],
      ),
    );
  }
}
