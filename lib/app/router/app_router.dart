import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/helpers/app_service.dart';
import 'package:naqaa/app/di/dependency_injection.dart';
import 'package:naqaa/app/router/app_routes.dart';
import 'package:naqaa/app/router/routes.dart';

class AppRouter {
  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey(debugLabel: 'root');

  static final GoRouter appRouter = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppScreen.home.toPath,
    redirect: _redirectToOnboarding,
    routes: <RouteBase>[
      AppRoutes.home,
      AppRoutes.onboarding,
      AppRoutes.signIn,
      AppRoutes.signUp,
      AppRoutes.forgotPassword,
    ],
  );

  static FutureOr<String?> _redirectToOnboarding(
      BuildContext context, GoRouterState state) {
    final AppService appService = instance<AppService>();
    if (!appService.onboarding) {
      return state.namedLocation(AppScreen.onboarding.toName);
    } else {
      return null;
    }
  }
}
