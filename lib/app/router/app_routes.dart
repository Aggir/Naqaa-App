import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/router/app_router.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/presentation/blocs/change_password/change_password_cubit.dart';
import 'package:naqaa/presentation/blocs/devices/devices_cubit.dart';
import 'package:naqaa/presentation/blocs/edit_profile/edit_profile_cubit.dart';
import 'package:naqaa/presentation/blocs/setup_device/setup_device_cubit.dart';
import 'package:naqaa/presentation/screens/index.dart';
import 'package:naqaa/presentation/blocs/index.dart';

import '../../presentation/blocs/user/user_cubit.dart';
import '../di/dependency_injection.dart';

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

  static final main = ShellRoute(
      navigatorKey: AppRouter.mainShellKey,
      pageBuilder: (context, state, child) => NoTransitionPage(
              child: BlocProvider(
            create: (context) => DevicesCubit(),
            child: MainScreen(child, state.uri),
          )),
      routes: [
        GoRoute(
          parentNavigatorKey: AppRouter.mainShellKey,
          redirect: _authenticatedRoute,
          path: AppScreen.home.toPath,
          name: AppScreen.home.toName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: HomePage());
          },
        ),
        GoRoute(
          parentNavigatorKey: AppRouter.mainShellKey,
          redirect: _authenticatedRoute,
          path: AppScreen.statistics.toPath,
          name: AppScreen.statistics.toName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: StatisticsPage());
          },
        ),
        GoRoute(
          parentNavigatorKey: AppRouter.mainShellKey,
          redirect: _authenticatedRoute,
          path: AppScreen.notifications.toPath,
          name: AppScreen.notifications.toName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: NotificationsPage());
          },
        ),
        GoRoute(
          parentNavigatorKey: AppRouter.mainShellKey,
          redirect: _authenticatedRoute,
          path: AppScreen.settings.toPath,
          name: AppScreen.settings.toName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: SettingsPage());
          },
        ),
      ]);

  static final changePassword = GoRoute(
    parentNavigatorKey: AppRouter.appNavigatorKey,
    redirect: _authenticatedRoute,
    path: AppScreen.changePassword.toPath,
    name: AppScreen.changePassword.toName,
    pageBuilder: (context, state) => CupertinoPage(
      child: BlocProvider(
        create: (context) => ChangePasswordCubit(),
        child: const ChangePasswordScreen(),
      ),
    ),
  );

  static final editProfile = GoRoute(
    parentNavigatorKey: AppRouter.appNavigatorKey,
    redirect: _authenticatedRoute,
    path: AppScreen.editProfile.toPath,
    name: AppScreen.editProfile.toName,
    pageBuilder: (context, state) => CupertinoPage(
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return BlocProvider(
            create: (context) => EditProfileCubit()..init(state.user),
            child: const EditProfileScreen(),
          );
        },
      ),
    ),
  );

  static final appSettings = GoRoute(
    parentNavigatorKey: AppRouter.appNavigatorKey,
    redirect: _authenticatedRoute,
    path: AppScreen.appSettings.toPath,
    name: AppScreen.appSettings.toName,
    pageBuilder: (context, state) => const CupertinoPage(
      child: AppSettingsScreen(),
    ),
  );

  static final termsOfUse = GoRoute(
    parentNavigatorKey: AppRouter.appNavigatorKey,
    path: AppScreen.termsOfUse.toPath,
    name: AppScreen.termsOfUse.toName,
    pageBuilder: (context, state) => const CupertinoPage(
      child: TermsOfUseScreen(),
    ),
  );

  static final privacyPolicy = GoRoute(
    parentNavigatorKey: AppRouter.appNavigatorKey,
    path: AppScreen.privacyPolicy.toPath,
    name: AppScreen.privacyPolicy.toName,
    pageBuilder: (context, state) => const CupertinoPage(
      child: PrivacyPolicyScreen(),
    ),
  );

  static final aboutUs = GoRoute(
    parentNavigatorKey: AppRouter.appNavigatorKey,
    path: AppScreen.aboutUs.toPath,
    name: AppScreen.aboutUs.toName,
    pageBuilder: (context, state) => const CupertinoPage(
      child: AboutUsScreen(),
    ),
  );

  static final setupDeviceOnboarding = GoRoute(
    parentNavigatorKey: AppRouter.appNavigatorKey,
    redirect: _authenticatedRoute,
    path: AppScreen.setupDeviceOnboarding.toPath,
    name: AppScreen.setupDeviceOnboarding.toName,
    pageBuilder: (context, state) {
      return CupertinoPage(
        child: SetupDeviceOnboardingScreen(
          pageIndex: (state.extra as int?),
        ),
      );
    },
  );

  static final setupDeviceSteps = StatefulShellRoute.indexedStack(
      builder: (context, state, child) => BlocProvider(
          create: (context) => SetupDeviceCubit(),
          child: SetupDeviceScreen(child)),
      branches: setupBranches);

  static final setupBranches = [
    StatefulShellBranch(routes: [setupDeviceSelectNetwork]),
    StatefulShellBranch(routes: [addDeviceName]),
  ];

  static final setupDeviceSelectNetwork = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.setupDeviceSelectNetwork.toPath,
    name: AppScreen.setupDeviceSelectNetwork.toName,
    builder: (context, state) => const SetupDeviceSelectNetworkPage(),
  );

  static final addDeviceName = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.setupDeviceAddDeviceName.toPath,
    name: AppScreen.setupDeviceAddDeviceName.toName,
    pageBuilder: (context, state) =>
        const NoTransitionPage(child: SetupDeviceAddDeviceNamePage()),
  );

  static final faq = GoRoute(
    parentNavigatorKey: AppRouter.appNavigatorKey,
    redirect: _authenticatedRoute,
    path: AppScreen.faq.toPath,
    name: AppScreen.faq.toName,
    pageBuilder: (context, state) => const CupertinoPage(child: FAQScreen()),
  );

  static final deviceDetails = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.deviceDetails.toPath,
    name: AppScreen.deviceDetails.toName,
    pageBuilder: (context, state) {
      return const NoTransitionPage(child: DeviceDetailsScreen());
    },
  );

  // Todo: Refactor redirect functions.
  static FutureOr<String?> _authenticatedRoute(
      BuildContext context, GoRouterState state) {
    final auth = instance<FirebaseAuth>();
    if (auth.currentUser == null) {
      return state.namedLocation(AppScreen.signIn.toName);
    } else {
      return null;
    }
  }

  static FutureOr<String?> _nonAuthenticatedRoute(
      BuildContext context, GoRouterState state) {
    final auth = instance<FirebaseAuth>();
    if (auth.currentUser != null) {
      return state.namedLocation(AppScreen.home.toName);
    } else {
      return null;
    }
  }
}
