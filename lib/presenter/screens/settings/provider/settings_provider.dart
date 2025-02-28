import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_learning/presenter/screens/settings/settings_options.dart';

class SettingsProvider extends ChangeNotifier {
  final List<SettingsOption> _settings = [
    SettingsOption.languages,
    SettingsOption.timing,
    SettingsOption.password,
    SettingsOption.terms,
    SettingsOption.configuration,
  ];

  List<SettingsOption> get settings => _settings;
}
