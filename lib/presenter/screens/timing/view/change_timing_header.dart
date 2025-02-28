import 'package:flutter/material.dart';
import 'package:language_learning/presenter/widgets/heading_text.dart';

class ChangeTimingHeader extends StatelessWidget {
  const ChangeTimingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return HeadingText(
      headingText: 'Chosen time for learning',
      secondaryText: 'Chosen time for receiving notifications',
    );
  }
}
