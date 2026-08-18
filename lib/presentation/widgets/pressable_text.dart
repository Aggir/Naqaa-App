import 'package:flutter/material.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';

import '../theme/text_style_manager.dart';

class PressableText extends StatelessWidget {
  const PressableText({
    required this.text,
    this.onTap,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    super.key,
  });
  final String text;
  final void Function()? onTap;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    Color getTextColor() {
      if (textColor != null) return textColor!;
      if (onTap == null) return AppColors.primary.withOpacity(0.3);
      return AppColors.primary;
    }

    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: pressableTextStyle().copyWith(
            fontSize: fontSize, fontWeight: fontWeight, color: getTextColor()),
      ),
    );
  }
}
