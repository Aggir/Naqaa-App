import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';

import '../theme/app_colors.dart';
import '../theme/text_style_manager.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    required this.onPressed,
    required this.child,
    this.style,
    super.key,
  });

  final void Function() onPressed;
  final ButtonStyle? style;
  final Widget child;

  static final customStyle = OutlinedButton.styleFrom(
    textStyle: regularPrimaryStyle(),
    side: BorderSide(color: AppColors.primary),
    minimumSize: AppValues.buttonMinSize,
    padding: const EdgeInsets.all(AppValues.small + (AppValues.small / 2)).r,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppValues.mediumSmallRadius.r),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: style ?? customStyle,
      onPressed: onPressed,
      child: child,
    );
  }

  static Widget fullWidth(
      {void Function()? onPressed,
      required Widget child,
      ButtonStyle? style,
      bool isLoading = false}) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: style ?? customStyle,
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                height: AppSizes.s25.r,
                width: AppSizes.s25.r,
                child: CircularProgressIndicator(
                  color: AppColors.snowWhite,
                ),
              )
            : child,
      ),
    );
  }
}
