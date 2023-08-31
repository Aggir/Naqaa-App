import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class CustomToast {
  static void _toast(
      BuildContext context, String message, Color backgroundColor) {
    final FToast fToast = FToast();
    fToast.init(context);
    fToast.removeCustomToast();
    fToast.showToast(
      child: GestureDetector(
        onTap: () => fToast.removeCustomToast(),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppValues.mediumSmall,
            vertical: AppValues.mediumSmall,
          ).r,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppValues.smallRadius.r),
          ),
          child: Text(
            message,
            style: regularWhiteSmallStyle(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
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
