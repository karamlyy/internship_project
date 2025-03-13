import 'package:flutter/material.dart';
import 'package:language_learning/presenter/widgets/heading_text.dart';
import 'package:language_learning/utils/l10n/l10n.dart';

class ChangeTimingHeader extends StatelessWidget {
  const ChangeTimingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return HeadingText(
      headingText: L10n.chosenTimeHeader,
      secondaryText: L10n.chooseTimeSubheader,
    );
  }
}
