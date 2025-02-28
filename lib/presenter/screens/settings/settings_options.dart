import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_learning/utils/routes/app_routes.dart';

enum SettingsOption {
  languages(title: 'Languages', icon: CupertinoIcons.globe, route: Routes.addLanguagePair),
  timing(title: 'Timing', icon: CupertinoIcons.clock, route: Routes.changeTiming),
  password(title: 'Password', icon: CupertinoIcons.lock_fill, route: Routes.changePassword),
  terms(title: 'Terms and Conditions', icon: CupertinoIcons.book, route: Routes.termsConditions),
  configuration(title: 'Configuration', icon: CupertinoIcons.settings, route: Routes.configuration),
  deleteAccount(title: 'Delete Account', icon: CupertinoIcons.delete, route: Routes.changePassword),
  logout(title: 'Log out', icon: Icons.login_outlined, route: Routes.changePassword);

  final String title;
  final IconData icon;
  final Routes route;

  const SettingsOption({required this.title, required this.icon, required this.route});
}
