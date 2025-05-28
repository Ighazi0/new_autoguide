import 'dart:developer';
import 'package:autoguide/models/user_model.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:autoguide/services/theme_services.dart';
import 'package:dio/dio.dart';
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
  final selectedType = ValueNotifier(0);
  final isDarkMode = ValueNotifier(ThemeServices.isDarkMode);
  UserModel? get userData => userDataNotifier.value;

  Future<double?> getPiPriceInUSD() async {
    final url =
        'https://api.coingecko.com/api/v3/simple/price?ids=pi-network&vs_currencies=usd';

    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        return data['pi-network']['usd']?.toDouble();
      }
    } catch (e) {
      log('getPiPriceInUSD: $e');
    }
    return null;
  }
}
