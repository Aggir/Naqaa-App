import 'package:flutter/material.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';

class SecondaryIconButton extends StatelessWidget {
  const SecondaryIconButton({
    required this.onPressed,
    required this.label,
    required this.icon,
    super.key,
  });

  final void Function()? onPressed;
  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        textStyle: secondaryButtonTextStyle(),
        disabledForegroundColor: AppColors.primary,
        side: BorderSide(color: AppColors.primary),
        minimumSize: AppValues.buttonMinSize,
        padding: const EdgeInsets.all(AppValues.small + (AppValues.small / 2)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppValues.primaryButtonRadius),
        ),
      ),
      onPressed: onPressed,
      label: label,
      icon: icon,
    );
  }
}
