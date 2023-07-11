import 'package:flutter/material.dart';

enum LanguageType {
  arabic,
  english,
}

const Locale arabicLocale = Locale('ar', 'SA');
const Locale englishLocale = Locale('en', 'US');

const List<Locale> locales = [arabicLocale, englishLocale];

const String assetsPathLocalization = 'assets/localization';

extension LanguageTypeExtension on LanguageType {
  Locale getLocale() {
    switch (this) {
      case LanguageType.arabic:
        return arabicLocale;
      case LanguageType.english:
        return englishLocale;
    }
  }
}
