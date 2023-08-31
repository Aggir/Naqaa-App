import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';

import '../theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.onPressed,
    this.style,
    required this.child,
    this.isLoading = false,
    this.customSize,
    this.color,
    super.key,
  });

  final void Function() onPressed;
  final Widget child;
  final ButtonStyle? style;
  final bool isLoading;
  final Size? customSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final customStyle = ElevatedButton.styleFrom(
      textStyle: primaryButtonTextStyle(),
      minimumSize: customSize ?? AppValues.buttonMinSize,
      backgroundColor: color,
      disabledBackgroundColor: color ?? AppColors.primary,
      disabledForegroundColor: AppColors.snowWhite,
      padding: const EdgeInsets.all(AppValues.mediumSmall).r,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppValues.mediumSmallRadius.r),
      ),
    );
    return ElevatedButton(
      style: style ?? customStyle,
      onPressed: isLoading ? () {} : onPressed,
      child: isLoading
          ? SizedBox(
              height: AppSizes.s25.r,
              width: AppSizes.s25.r,
              child: const CircularProgressIndicator(
                color: AppColors.snowWhite,
              ),
            )
          : child,
    );
  }

  static Widget fullWidth({
    void Function()? onPressed,
    required Widget child,
    ButtonStyle? style,
    Color? color,
    bool isLoading = false,
  }) {
    final customStyle = ElevatedButton.styleFrom(
      textStyle: primaryButtonTextStyle(),
      minimumSize: AppValues.buttonMinSize,
      backgroundColor: color,
      disabledBackgroundColor: color ?? AppColors.primary,
      disabledForegroundColor: AppColors.snowWhite,
      padding: const EdgeInsets.all(AppValues.mediumSmall).r,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppValues.mediumSmallRadius.r),
      ),
    );
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: style ?? customStyle,
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                height: AppSizes.s25.r,
                width: AppSizes.s25.r,
                child: const CircularProgressIndicator(
                  color: AppColors.snowWhite,
                ),
              )
            : child,
      ),
    );
  }
}
