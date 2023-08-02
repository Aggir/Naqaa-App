import 'package:flutter/material.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';

import '../theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.onPressed,
    this.style,
    required this.child,
    this.isLoading = false,
    super.key,
  });

  final void Function() onPressed;
  final Widget child;
  final ButtonStyle? style;
  final bool isLoading;

  static final customStyle = ElevatedButton.styleFrom(
    minimumSize: AppValues.buttonMinSize,
    disabledBackgroundColor: AppColors.primary,
    disabledForegroundColor: AppColors.snowWhite,
    padding: const EdgeInsets.all(AppValues.small + (AppValues.small / 2)),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppValues.primaryButtonRadius),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style ?? customStyle,
      onPressed: isLoading ? () {} : onPressed,
      child: isLoading
          ? SizedBox(
              height: AppSizes.s25,
              width: AppSizes.s25,
              child: CircularProgressIndicator(
                color: AppColors.snowWhite,
              ),
            )
          : child,
    );
  }

  static Widget fullWidth(
      {void Function()? onPressed,
      required Widget child,
      ButtonStyle? style,
      bool isLoading = false}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: style ?? customStyle,
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                height: AppSizes.s25,
                width: AppSizes.s25,
                child: CircularProgressIndicator(
                  color: AppColors.snowWhite,
                ),
              )
            : child,
      ),
    );
  }
}
