import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_learning/presenter/screens/settings/provider/settings_provider.dart';
import 'package:language_learning/presenter/widgets/settings_card.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/l10n/l10n.dart';
import 'package:language_learning/utils/routes/navigation.dart';
import 'package:provider/provider.dart';

class SettingsMain extends StatelessWidget {
  const SettingsMain({super.key});

  String getLocalizedSettingTitle(String key) {
    switch (key) {
      case 'languages':
        return L10n.languages;
      case 'notifications':
        return L10n.notifications;
      case 'changePassword':
        return L10n.changePassword;
      case 'termsAndConditions':
        return L10n.termsAndConditions;
      case 'configurations':
        return L10n.configurations;

      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();

    return Expanded(
      child: ListView.builder(
        itemCount: settingsProvider.settings.length,
        itemBuilder: (BuildContext context, int index) {
          final setting = settingsProvider.settings[index];

          return SettingsCard(
            title: getLocalizedSettingTitle(setting.titleKey),
            leadingIcon: Icon(setting.icon, color: AppColors.primary),
            onTap: () {
              Navigation.push(setting.route);
            },
          );
        },
      ),
    );
  }
}
