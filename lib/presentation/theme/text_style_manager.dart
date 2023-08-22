import 'package:flutter/material.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/font_manager.dart';
import 'package:naqaa/presentation/theme/styles_manager.dart';

TextStyle primaryButtonTextStyle() {
  return getSemiBoldStyle(fontSize: FontSize.s14, color: AppColors.whiteText);
}

TextStyle regularPrimaryStyle() {
  return getRegularStyle(fontSize: FontSize.s14, color: AppColors.primary);
}

TextStyle textFieldHintStyle() {
  return getRegularStyle(fontSize: FontSize.s14, color: AppColors.hintText);
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
  return getRegularStyle(fontSize: FontSize.s12, color: AppColors.mediumGray);
}

TextStyle pressableTextStyle() {
  return getRegularStyle(fontSize: FontSize.s14, color: AppColors.primary);
}

// Refactor fonts

TextStyle boldBlackHugeStyle() {
  return getBoldStyle(fontSize: FontSize.s30, color: AppColors.blackText);
}

TextStyle semiGrayStyle() {
  return getSemiBoldStyle(fontSize: FontSize.s14, color: AppColors.mediumGray);
}

TextStyle semiBlackStyle() {
  return getSemiBoldStyle(fontSize: FontSize.s14, color: AppColors.blackText);
}

TextStyle semiBlackMediumStyle() {
  return getSemiBoldStyle(fontSize: FontSize.s18, color: AppColors.blackText);
}

TextStyle semiPrimaryStyle() {
  return getSemiBoldStyle(fontSize: FontSize.s14, color: AppColors.mediumGray);
}

TextStyle semiBluishGrayStyle() {
  return getSemiBoldStyle(fontSize: FontSize.s14, color: AppColors.bluishGray);
}

TextStyle semiPrimarySmallStyle() {
  return getSemiBoldStyle(fontSize: FontSize.s12, color: AppColors.primary);
}

TextStyle semiBluishGrayExtraSmallStyle() {
  return getSemiBoldStyle(fontSize: FontSize.s10, color: AppColors.bluishGray);
}

TextStyle boldPrimaryExtraSmallStyle() {
  return getBoldStyle(fontSize: FontSize.s8, color: AppColors.primary);
}

TextStyle boldPrimaryMediumStyle() {
  return getBoldStyle(fontSize: FontSize.s16, color: AppColors.primary);
}

TextStyle mediumBlackExtraLargeStyle() {
  return getMediumStyle(fontSize: FontSize.s26, color: AppColors.blackText);
}

TextStyle regularGrayStyle() {
  return getRegularStyle(fontSize: FontSize.s14, color: AppColors.mediumGray);
}

TextStyle regularGraySmallStyle() {
  return getRegularStyle(fontSize: FontSize.s12, color: AppColors.mediumGray);
}

TextStyle regularWhiteSmallStyle() {
  return getRegularStyle(fontSize: FontSize.s12, color: AppColors.whiteText);
}

TextStyle regularBlackStyle() {
  return getRegularStyle(fontSize: FontSize.s14, color: AppColors.blackText);
}

TextStyle regularDarkGrayMediumStyle() {
  return getRegularStyle(fontSize: FontSize.s16, color: AppColors.darkGray);
}

TextStyle regularBluishGrayMediumStyle() {
  return getRegularStyle(fontSize: FontSize.s16, color: AppColors.bluishGray);
}

TextStyle regularPrimaryMediumStyle() {
  return getRegularStyle(fontSize: FontSize.s16, color: AppColors.primary);
}

TextStyle regularPrimarySmallStyle() {
  return getRegularStyle(fontSize: FontSize.s12, color: AppColors.primary);
}

TextStyle regularBluishGraySmallStyle() {
  return getRegularStyle(fontSize: FontSize.s12, color: AppColors.bluishGray);
}

TextStyle semiBlackSmallStyle() {
  return getSemiBoldStyle(fontSize: FontSize.s12, color: AppColors.blackText);
}

TextStyle boldDarkBlueLargeStyle() {
  return getBoldStyle(fontSize: FontSize.s20, color: AppColors.darkBlue);
}

TextStyle boldWhiteHugeStyle() {
  return getBoldStyle(fontSize: FontSize.s46, color: AppColors.snowWhite);
}

TextStyle boldBlackExtraLargeStyle() {
  return getBoldStyle(fontSize: FontSize.s26, color: AppColors.blackText);
}

TextStyle regularGrayExtraSmallStyle() {
  return getRegularStyle(fontSize: FontSize.s10, color: AppColors.mediumGray);
}

TextStyle regularBluishGrayExtraSmallStyle() {
  return getRegularStyle(fontSize: FontSize.s10, color: AppColors.mediumGray);
}

TextStyle regularRedExtraSmallStyle() {
  return getRegularStyle(fontSize: FontSize.s10, color: AppColors.red);
}

TextStyle boldBlackMediumStyle() {
  return getBoldStyle(fontSize: FontSize.s16, color: AppColors.blackText);
}

TextStyle boldBlackLargeStyle() {
  return getBoldStyle(fontSize: FontSize.s20, color: AppColors.blackText);
}
