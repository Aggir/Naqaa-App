import 'package:flutter/material.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/font_manager.dart';
import 'package:naqaa/presentation/theme/styles_manager.dart';

TextStyle onboardingTitleStyle() {
  return getBoldStyle(fontSize: FontSize.s26, color: AppColors.blackText);
}

TextStyle descriptionTextStyle() {
  return getRegularStyle(fontSize: FontSize.s16, color: AppColors.darkGrayText);
}

TextStyle primaryButtonTextStyle() {
  return getSemiBoldStyle(fontSize: FontSize.s14, color: AppColors.whiteText);
}

TextStyle secondaryButtonTextStyle() {
  return getRegularStyle(fontSize: FontSize.s14, color: AppColors.primary);
}

TextStyle textFieldHintStyle() {
  return getRegularStyle(fontSize: FontSize.s16, color: AppColors.hintText);
}

TextStyle appBarTitleTextStyle() {
  return getSemiBoldStyle(fontSize: FontSize.s16, color: AppColors.blackText);
}

TextStyle smallWithOpacityTextStyle() {
  return getRegularStyle(
      fontSize: FontSize.s12, color: AppColors.blackText.withOpacity(0.64));
}

TextStyle bodySmallTextStyle() {
  return getRegularStyle(fontSize: FontSize.s12, color: AppColors.blackText);
}

TextStyle bodySmallGrayTextStyle() {
  return getRegularStyle(fontSize: FontSize.s12, color: AppColors.lightGray);
}

TextStyle headlineTextStyle() {
  return getBoldStyle(fontSize: FontSize.s30, color: AppColors.blackText);
}

TextStyle bodyMediumTextStyle() {
  return getRegularStyle(fontSize: FontSize.s14, color: AppColors.lightGray);
}

TextStyle pressableTextStyle() {
  return getRegularStyle(fontSize: FontSize.s14, color: AppColors.primary);
}
