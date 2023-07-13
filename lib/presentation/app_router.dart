import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/presentation/screens/login/login_screen.dart';
import 'package:naqaa/presentation/screens/home_screen.dart';
import 'package:naqaa/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:naqaa/presentation/screens/sign_up/sign_up_screen.dart';

class Routes {
  static const String onboardingRoute = "/onboarding";
  static const String homeRoute = "/";
  static const String loginRoute = "/login";
  static const String signUpRoute = "/sign-up";
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
      GoRoute(
        path: Routes.loginRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: Routes.signUpRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpScreen();
        },
      ),
    ],
  );
}
