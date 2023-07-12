import 'package:flutter/material.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/styles_manager.dart';

TextStyle onboardingTitleStyle() {
  return getBoldStyle(fontSize: 26, color: AppColors.blackText);
}

TextStyle onboardingSubtitleStyle() {
  return getRegularStyle(fontSize: 16, color: AppColors.darkGrayText);
}

TextStyle getStartedButtonTextStyle() {
  return getSemiBoldStyle(fontSize: 14, color: AppColors.whiteText);
}
