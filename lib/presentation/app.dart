import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naqaa/presentation/app_router.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';

import '../app/constants.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal({Key? key}) : super(key: key);

  static const MyApp _instance = MyApp._internal();
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _setFirebaseAuthLanguage(BuildContext context) async {
    await FirebaseAuth.instance.setLanguageCode(context.locale.toString());
  }

  @override
  Widget build(BuildContext context) {
    _setFirebaseAuthLanguage(context);
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      theme: appThemeData(),
      routerConfig: AppRouter.appRouter,
    );
  }
}
