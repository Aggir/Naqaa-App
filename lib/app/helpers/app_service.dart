import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/di/dependency_injection.dart';
import 'package:naqaa/app/router/app_router.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: non_constant_identifier_names
String LOGIN_KEY = "5FD6G46SDF4GD64F1VG9SD68";
// ignore: non_constant_identifier_names
String ONBOARD_KEY = "GD2G82CG9G82VDFGVD22DVG";
// ignore: non_constant_identifier_names
String TOKEN = "31LNB3THO834H8I34G2349VCE8";

class AppService with ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  final StreamController<bool> _loginStateChange =
      StreamController<bool>.broadcast();
  bool _loginState = false;
  bool _initialized = false;
  bool _onboarding = false;

  AppService(this.sharedPreferences);

  bool get loginState => _loginState;
  bool get initialized => _initialized;
  bool get onboarding => _onboarding;
  Stream<bool> get loginStateChange => _loginStateChange.stream;

  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  set onboarding(bool value) {
    sharedPreferences.setBool(ONBOARD_KEY, value);
    _onboarding = value;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    _onboarding = sharedPreferences.getBool(ONBOARD_KEY) ?? false;
    final auth = instance<FirebaseAuth>();
    _loginState = auth.currentUser != null;
    _initialized = true;
    notifyListeners();

    auth.authStateChanges().listen((User? user) {
      _loginState = user != null;
      // todo: remove from here and add it to a BlocListener
      if (AppRouter.rootNavigatorKey.currentContext != null) {
        GoRouter.of(AppRouter.rootNavigatorKey.currentContext!)
            .go(AppScreen.signIn.toPath);
      }
      notifyListeners();
    });
  }
}
