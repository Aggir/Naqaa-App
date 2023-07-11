import 'package:flutter/material.dart';
import 'package:naqaa/presentation/app_router.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: appThemeData(),
      routerConfig: AppRouter.appRouter,
    );
  }
}
