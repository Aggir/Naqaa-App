import 'package:flutter/material.dart';
import 'package:naqaa/presentation/app.dart';
import 'package:easy_localization/easy_localization.dart';

import 'app/language_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      startLocale: defaultLocale,
      supportedLocales: appLocales,
      path: assetsPathLocalization,
      fallbackLocale: defaultLocale,
      saveLocale: true,
      child: MyApp(),
    ),
  );
}
