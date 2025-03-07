import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_learning/utils/l10n/l10n.dart';
import 'package:language_learning/utils/routes/app_routes.dart';

enum SettingsOption {
  languages(icon: CupertinoIcons.globe, route: Routes.addLanguagePair, titleKey: 'languages'),
  timing(icon: CupertinoIcons.clock, route: Routes.changeTiming, titleKey: 'notifications'),
  password(icon: CupertinoIcons.lock_fill, route: Routes.changePassword, titleKey: 'changePassword'),
  terms(icon: CupertinoIcons.book, route: Routes.termsConditions, titleKey: 'termsAndConditions'),
  configuration(icon: CupertinoIcons.settings, route: Routes.configuration, titleKey: 'configurations'),
  deleteAccount(icon: CupertinoIcons.delete, route: Routes.changePassword, titleKey: 'deleteAccount'),
  logout(icon: Icons.login_outlined, route: Routes.changePassword, titleKey: 'logoutAccount');

  final String titleKey;
  final IconData icon;
  final Routes route;

  const SettingsOption({required this.titleKey, required this.icon, required this.route});
}