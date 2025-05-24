import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/controllers/main_controller.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:autoguide/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class InitApp extends StatelessWidget {
  const InitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ValueListenableBuilder<Locale>(
        valueListenable: MainController().selectedLangauge,
        builder: (context, selectedLangauge, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            scaffoldMessengerKey: scaffoldMessengerKey,
            theme: AppStyle.themeData,
            locale: selectedLangauge,
            supportedLocales: LocaleServices.languages.keys
                .map((lang) => Locale(lang))
                .toList(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.linear(1)),
                child: child ?? SizedBox(),
              );
            },
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
