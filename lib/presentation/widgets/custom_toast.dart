import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class CustomToast {
  static void _toast(
      BuildContext context, String message, Color backgroundColor) {
    showStyledToast(
      child: Text(message),
      context: context,
      backgroundColor: backgroundColor,
      borderRadius: BorderRadius.circular(AppValues.smallRadius.r),
      contentPadding: const EdgeInsets.symmetric(
              horizontal: AppValues.medium, vertical: AppValues.medium)
          .r,
      margin: const EdgeInsets.symmetric(
              vertical: AppValues.extraLarge, horizontal: AppValues.mediumLarge)
          .r,
    );
  }

  static void info(BuildContext context, String message) {
    _toast(context, message, AppColors.mediumGray);
  }

  static void warning(BuildContext context, String message) {}

  static void success(BuildContext context, String message) {
    _toast(context, message, AppColors.green);
  }

  static void error(BuildContext context, String message) {
    _toast(context, message, AppColors.red);
  }
}
