import 'package:flutter/material.dart';
import 'package:language_learning/presenter/widgets/heading_text.dart';

class ChangePasswordHeader extends StatelessWidget {
  const ChangePasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return HeadingText(
      headingText: 'Change Password',
      secondaryText: 'Please type something you’ll remember',
    );
  }
}
