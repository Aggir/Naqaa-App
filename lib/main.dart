import 'package:flutter/material.dart';
import 'package:naqaa/app/helpers/app_service.dart';
import 'package:naqaa/presentation/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/di/dependency_injection.dart';
import 'firebase_options.dart';

import 'app/language_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initAppModule();
  await instance<AppService>().onAppStart();
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
