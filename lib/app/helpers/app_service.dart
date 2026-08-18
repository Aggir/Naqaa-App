import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: non_constant_identifier_names
String ONBOARD_KEY = "GD2G82CG9G82VDFGVD22DVG";

class AppService with ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  bool _initialized = false;
  bool _onboarding = false;

  AppService(this.sharedPreferences);

  bool get initialized => _initialized;
  bool get onboarding => _onboarding;

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
    _initialized = true;
    notifyListeners();
  }
}
