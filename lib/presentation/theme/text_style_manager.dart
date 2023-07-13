import 'package:flutter/material.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/styles_manager.dart';

TextStyle onboardingTitleStyle() {
  return getBoldStyle(fontSize: 26, color: AppColors.blackText);
}

TextStyle descriptionTextStyle() {
  return getRegularStyle(fontSize: 16, color: AppColors.darkGrayText);
}

TextStyle primaryButtonTextStyle() {
  return getSemiBoldStyle(fontSize: 14, color: AppColors.whiteText);
}

TextStyle secondaryButtonTextStyle() {
  return getRegularStyle(fontSize: 14, color: AppColors.primary);
}

TextStyle textFieldHintStyle() {
  return getRegularStyle(fontSize: 16, color: AppColors.hintText);
}

TextStyle appBarTitleTextStyle() {
  return getSemiBoldStyle(fontSize: 16, color: AppColors.blackText);
}

TextStyle smallWithOpacityTextStyle() {
  return getRegularStyle(
      fontSize: 12, color: AppColors.blackText.withOpacity(0.64));
}

TextStyle bodySmallTextStyle() {
  return getRegularStyle(fontSize: 12, color: AppColors.lightGray);
}
