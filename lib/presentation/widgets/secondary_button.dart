import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';

import '../theme/app_colors.dart';
import '../theme/text_style_manager.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    required this.onPressed,
    required this.child,
    super.key,
  });

  final void Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        textStyle: secondaryButtonTextStyle(),
        side: BorderSide(color: AppColors.primary),
        minimumSize: AppValues.buttonMinSize,
        padding:
            const EdgeInsets.all(AppValues.small + (AppValues.small / 2)).r,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppValues.mediumSmallRadius.r),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
