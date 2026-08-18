import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';

class PrimaryIconButton extends StatelessWidget {
  const PrimaryIconButton({
    required this.onPressed,
    required this.label,
    required this.icon,
    super.key,
  });

  final void Function() onPressed;
  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: AppValues.buttonMinSize,
        padding:
            const EdgeInsets.all(AppValues.small + (AppValues.small / 2)).r,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppValues.mediumSmallRadius.r),
        ),
      ),
      onPressed: onPressed,
      label: label,
      icon: icon,
    );
  }
}
