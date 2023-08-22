import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/bloc_listenable.dart';
import 'package:naqaa/app/helpers/app_service.dart';
import 'package:naqaa/app/di/dependency_injection.dart';
import 'package:naqaa/app/router/app_routes.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/presentation/blocs/user/user_cubit.dart';

class AppRouter {
  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey(debugLabel: 'root');
  static GlobalKey<NavigatorState> appNavigatorKey =
      GlobalKey(debugLabel: 'app');
  static GlobalKey<NavigatorState> mainShellKey =
      GlobalKey(debugLabel: 'mainShell');
  static GlobalKey<NavigatorState> setupDeviceStepsShellKey =
      GlobalKey(debugLabel: 'setupDeviceStepsShell');

  static final GoRouter appRouter = GoRouter(
    refreshListenable: BlocListenable(instance<UserCubit>()),
    navigatorKey: rootNavigatorKey,
    initialLocation: AppScreen.home.toPath,
    redirect: _redirectToOnboarding,
    routes: <RouteBase>[
      AppRoutes.onboarding,
      AppRoutes.signIn,
      AppRoutes.signUp,
      AppRoutes.forgotPassword,
      AppRoutes.main,
      AppRoutes.changePassword,
      AppRoutes.editProfile,
      AppRoutes.appSettings,
      AppRoutes.termsOfUse,
      AppRoutes.privacyPolicy,
      AppRoutes.aboutUs,
      AppRoutes.setupDeviceOnboarding,
      // AppRoutes.setupDeviceSelectNetwork,
      AppRoutes.setupDeviceSteps,
      // ShellRoute(
      //   navigatorKey: appNavigatorKey,
      //   routes: [],
      //   builder: (context, state, child) => BlocProvider(
      //     create: (context) => instance<UserCubit>()..onAppStart(),
      //     child: Builder(builder: (context) {
      //       return BlocListener<UserCubit, UserState>(
      //         listenWhen: (previous, current) =>
      //             previous.user != current.user &&
      //             previous.authStatus != current.authStatus,
      //         listener: (context, state) {
      //           if (state.user == null) {
      //             context.go(AppScreen.signIn.toPath);
      //           } else {
      //             context.go(AppScreen.home.toPath);
      //           }
      //         },
      //         child: child,
      //       );
      //     }),
      //   ),
      // )
    ],
  );

  static FutureOr<String?> _redirectToOnboarding(
      BuildContext context, GoRouterState state) {
    final AppService appService = instance<AppService>();
    final cubit = BlocProvider.of<UserCubit>(context);
    if (!appService.onboarding) {
      return state.namedLocation(AppScreen.onboarding.toName);
    } else if (cubit.state.user == null) {
      return state.namedLocation(AppScreen.signIn.toName);
    } else {
      return null;
    }
  }
}
