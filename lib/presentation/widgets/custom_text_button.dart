import 'package:flutter/material.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {this.onPressed,
      required this.text,
      this.textColor = AppColors.primary,
      this.textStyle,
      super.key});
  final void Function()? onPressed;
  final String text;
  final Color textColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: textStyle ?? semiPrimarySmallStyle().copyWith(color: textColor),
      ),
    );
  }
}
