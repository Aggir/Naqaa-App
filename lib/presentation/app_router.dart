import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/presentation/blocs/forgot_password/forgot_password_cubit.dart';
import 'package:naqaa/presentation/blocs/sign_in/sign_in_cubit.dart';
import 'package:naqaa/presentation/blocs/sign_up/sign_up_cubit.dart';
import 'package:naqaa/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'package:naqaa/presentation/screens/forgot_password/pages/forgot_password_page.dart';
import 'package:naqaa/presentation/screens/forgot_password/pages/reset_password_instructions_sent_page.dart';
import 'package:naqaa/presentation/screens/sign_in/sign_in_screen.dart';
import 'package:naqaa/presentation/screens/home_screen.dart';
import 'package:naqaa/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:naqaa/presentation/screens/sign_up/sign_up_screen.dart';

class NavigatorKeys {
  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey(debugLabel: 'root');
}

class Routes {
  static const String onboardingRoute = "/onboarding";
  static const String homeRoute = "/";
  static const String signInRoute = "/sign-in";
  static const String signUpRoute = "/sign-up";
  static const String forgotPasswordRoute = "/reset-password";
  static const String forgotPasswordInstructionsSentRoute =
      "/reset-password-instructions-sent";
}

class AppRouter {
  static final GoRouter appRouter = GoRouter(
    navigatorKey: NavigatorKeys.rootNavigatorKey,
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
        path: Routes.signInRoute,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => SignInCubit(),
            child: const SignInScreen(),
          );
        },
      ),
      GoRoute(
        path: Routes.signUpRoute,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => SignUpCubit(),
            child: const SignUpScreen(),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) => BlocProvider(
                create: (context) => ForgotPasswordCubit(),
                child: ForgotPasswordScreen(navigationShell),
              ),
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(
                path: Routes.forgotPasswordRoute,
                builder: (BuildContext context, GoRouterState state) {
                  return const ForgotPasswordPage();
                },
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: Routes.forgotPasswordInstructionsSentRoute,
                builder: (BuildContext context, GoRouterState state) {
                  return const ResetPasswordInstructionsSentScreen();
                },
              ),
            ]),
          ]),
    ],
  );
}
