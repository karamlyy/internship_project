import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/screens/settings/view/setting_footer_buttons.dart';
import 'package:language_learning/presenter/screens/settings/view/settings_main.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SettingsMain(),
            SettingsFooterButtons(),
          ],
        ),
      ),
    );
  }
}
