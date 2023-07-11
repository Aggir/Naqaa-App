import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/presentation/screens/home_screen.dart';

class Routes {
  static const String homeRoute = "/";
}

class AppRouter {
  static final GoRouter appRouter = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: Routes.homeRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
    ],
  );
}
