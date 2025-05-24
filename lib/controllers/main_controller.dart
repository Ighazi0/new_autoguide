import 'package:autoguide/models/user_model.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:autoguide/services/theme_services.dart';
import 'package:flutter/material.dart';

class MainController {
  static MainController? _instance;
  MainController._privateConstructor();
  factory MainController() {
    _instance ??= MainController._privateConstructor();
    return _instance!;
  }

  final ValueNotifier<UserModel?> userDataNotifier = ValueNotifier(null);
  final selectedLangauge = ValueNotifier(Locale(LocaleServices.localeCode));
  final isDarkMode = ValueNotifier(ThemeServices.isDarkMode);
}
