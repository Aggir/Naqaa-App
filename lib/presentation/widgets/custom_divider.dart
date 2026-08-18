import 'package:flutter/material.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({this.color, super.key});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.s1,
      color: color ?? AppColors.bluishGray.withOpacity(0.2),
    );
  }
}
