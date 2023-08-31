import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

enum LanguageType {
  arabic,
  english,
}

const Locale _arabicLocale = Locale('ar');
const Locale _englishLocale = Locale('en');

const List<Locale> appLocales = [_arabicLocale, _englishLocale];
Locale get defaultLocale => _englishLocale;
const String assetsPathLocalization = 'assets/localization';

extension LanguageTypeExtension on LanguageType {
  Locale getLocale() {
    switch (this) {
      case LanguageType.arabic:
        return _arabicLocale;
      case LanguageType.english:
        return _englishLocale;
    }
  }
}

// Works only with two languages [AR, EN]
String getChangeLangText(BuildContext context) {
  Locale currentLocale = Localizations.localeOf(context);
  switch (currentLocale) {
    case _arabicLocale:
      return _englishLocale.languageCode.toLowerCase();
    case _englishLocale:
      return _arabicLocale.languageCode.toLowerCase();
    default:
      return _englishLocale.languageCode.toLowerCase();
  }
}

// Works only with two languages [AR, EN]
void switchLanguage(BuildContext context) {
  Locale currentLocale = Localizations.localeOf(context);
  switch (currentLocale) {
    case _arabicLocale:
      context.setLocale(_englishLocale).then((value) => Restart.restartApp());
      break;
    case _englishLocale:
      context.setLocale(_arabicLocale).then((value) => Restart.restartApp());
      break;
    default:
      context.setLocale(_englishLocale).then((value) => Restart.restartApp());
  }
}
