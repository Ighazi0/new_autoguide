import 'package:autoguide/controllers/main_controller.dart';
import 'package:autoguide/data/keys_data.dart';
import 'package:autoguide/lang/ar_strings.dart';
import 'package:autoguide/lang/en_strings.dart';
import 'package:autoguide/models/language_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

extension LocalizationExtension on String {
  String get tr => LocaleServices.tr(this);
}

class LocaleServices {
  static Map<String, LanguageModel> languages = {
    'ar': LanguageModel(code: 'ar', title: 'arabic', flag: '🇯🇴', strings: ar),
    'en': LanguageModel(
      code: 'en',
      title: 'english',
      flag: '🇺🇸',
      strings: en,
    ),
  };

  static bool get isAr => (GetStorage().read(KeysData.locale) ?? 'ar') == 'ar';

  static String get localeCode {
    return GetStorage().read(KeysData.locale) ?? 'ar';
  }

  static LanguageModel languageData() {
    return languages[localeCode] ?? languages.values.first;
  }

  static Future<void> changeLocale() async {
    GetStorage().write(KeysData.locale, isAr ? 'en' : 'ar');
    MainController().selectedLangauge.value = Locale(localeCode);
  }

  static String tr(String key) {
    return languages[localeCode]?.strings[key] ?? key;
  }
}
