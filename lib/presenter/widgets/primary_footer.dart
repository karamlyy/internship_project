import 'package:flutter/material.dart';
import 'package:language_learning/utils/typography/app_typography.dart';

class PrimaryFooter extends StatelessWidget {
  final String? mainText;
  final String? secondaryText;

  final VoidCallback onTap;

  const PrimaryFooter({
    super.key,
    this.mainText,
    this.secondaryText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        overlayColor: Colors.transparent,
      ),
      child: RichText(
        text: TextSpan(
          text: secondaryText,
          style: AppTypography.secondaryText,
          children: [
            TextSpan(
              text: mainText,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}