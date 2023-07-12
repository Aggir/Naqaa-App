import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/presentation/screens/home_screen.dart';
import 'package:naqaa/presentation/screens/onboarding/onboarding_screen.dart';

class Routes {
  static const String onboardingRoute = "/onboarding";
  static const String homeRoute = "/";
}

class AppRouter {
  static final GoRouter appRouter = GoRouter(
    initialLocation: Routes.onboardingRoute,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.onboardingRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingScreen();
        },
      ),
      GoRoute(
        path: Routes.homeRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
    ],
  );
}
