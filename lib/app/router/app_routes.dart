import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/presentation/screens/index.dart';
import 'package:naqaa/presentation/blocs/index.dart';

import '../di/dependency_injection.dart';
import '../helpers/app_service.dart';

class AppRoutes {
  static final onboarding = GoRoute(
    redirect: _nonAuthenticatedRoute,
    path: AppScreen.onboarding.toPath,
    name: AppScreen.onboarding.toName,
    builder: (BuildContext context, GoRouterState state) {
      return const OnboardingScreen();
    },
  );

  static final signIn = GoRoute(
    redirect: _nonAuthenticatedRoute,
    path: AppScreen.signIn.toPath,
    name: AppScreen.signIn.toName,
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider(
        create: (context) => SignInCubit(),
        child: const SignInScreen(),
      );
    },
  );

  static final signUp = GoRoute(
    redirect: _nonAuthenticatedRoute,
    path: AppScreen.signUp.toPath,
    name: AppScreen.signUp.toName,
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider(
        create: (context) => SignUpCubit(),
        child: const SignUpScreen(),
      );
    },
  );

  static final forgotPassword = StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => BlocProvider(
            create: (context) => ForgotPasswordCubit(),
            child: ForgotPasswordScreen(navigationShell),
          ),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            redirect: _nonAuthenticatedRoute,
            path: AppScreen.forgotPassword.toPath,
            name: AppScreen.forgotPassword.toName,
            builder: (BuildContext context, GoRouterState state) {
              return const ForgotPasswordPage();
            },
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            redirect: _nonAuthenticatedRoute,
            path: AppScreen.forgotPasswordInstructionsSent.toPath,
            name: AppScreen.forgotPasswordInstructionsSent.toName,
            builder: (BuildContext context, GoRouterState state) {
              return const ResetPasswordInstructionsSentScreen();
            },
          ),
        ]),
      ]);

  static final home = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.home.toPath,
    name: AppScreen.home.toName,
    builder: (BuildContext context, GoRouterState state) {
      return const HomeScreen();
    },
  );

  static FutureOr<String?> _authenticatedRoute(
      BuildContext context, GoRouterState state) {
    final AppService appService = instance<AppService>();
    if (!appService.loginState) {
      return state.namedLocation(AppScreen.signIn.toName);
    } else {
      return null;
    }
  }

  static FutureOr<String?> _nonAuthenticatedRoute(
      BuildContext context, GoRouterState state) {
    final AppService appService = instance<AppService>();
    if (appService.loginState) {
      return state.namedLocation(AppScreen.home.toName);
    } else {
      return null;
    }
  }
}
