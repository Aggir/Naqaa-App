import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class CustomToast {
  static void _toast(
      BuildContext context, String message, Color backgroundColor) {
    showStyledToast(
      child: Text(message),
      context: context,
      backgroundColor: backgroundColor,
      borderRadius: BorderRadius.circular(AppValues.textFieldRadius),
      contentPadding: const EdgeInsets.symmetric(
          horizontal: AppValues.medium, vertical: AppValues.medium),
      margin: const EdgeInsets.symmetric(
          vertical: AppValues.extraLarge, horizontal: AppValues.mediumLarge),
    );
  }

  static void info(BuildContext context, String message) {}

  static void warning(BuildContext context, String message) {}

  static void success(BuildContext context, String message) {
    _toast(context, message, AppColors.green);
  }

  static void error(BuildContext context, String message) {
    _toast(context, message, AppColors.red);
  }
}
