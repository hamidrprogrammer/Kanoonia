import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppDefaultLocale {
  static Locale getAppLocale = const Locale("fa", "IR");
  static List<Locale> supportedLocale = [getAppLocale];
  static List<LocalizationsDelegate> localizationDelegate = const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}
