import 'package:flutter/material.dart';
import 'package:language_learning/presenter/screens/auth/languages/provider/languages_provider.dart';
import 'package:language_learning/presenter/widgets/heading_text.dart';
import 'package:provider/provider.dart';

class SetLanguageHeader extends StatelessWidget {
  const SetLanguageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final languagesProvider = context.watch<LanguagesProvider>();

    return HeadingText(
      headingText: languagesProvider.isSourceLanguageSelected
          ? 'Choose Learning Language'
          : 'Choose Native Language',
      secondaryText: languagesProvider.isSourceLanguageSelected
          ? 'Select the language you want to learn.'
          : 'Select your native language to personalize your learning experience.',
    );
  }
}
