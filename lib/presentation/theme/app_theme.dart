import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';

import 'app_colors.dart';

ThemeData appThemeData() => ThemeData(
      scaffoldBackgroundColor: AppColors.cloudWhite,
      colorScheme: ThemeData().colorScheme.copyWith(
          primary: AppColors.primary, secondary: AppColors.cloudWhite),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        centerTitle: true,
        elevation: 0,
        color: AppColors.transparent,
        titleTextStyle: appBarTitleTextStyle(),
      ),
    );

class AppValues {
  // Padding and Margin
  static const double extraSmall = 4.0;
  static const double small = 8.0;
  static const double mediumSmall = 12.0;
  static const double medium = 16.0;
  static const double mediumLarge = 24.0;
  static const double large = 32.0;
  static const double extraLarge = 48.0;
  // Radius
  static const double circleRadius = 100;
  static const double toastRadius = 10;
  static const double primaryButtonRadius = 8;
  static const double textFieldRadius = 6;
  // Sizes
  static const Size buttonMinSize = Size(25, 50);
}

class AppSizes {
  static const double s2 = 2;
  static const double s4 = 4;
  static const double s5 = 5;
  static const double s6 = 6;
  static const double s8 = 8;
  static const double s10 = 10;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s22 = 22;
  static const double s24 = 24;
  static const double s25 = 25;
  static const double s26 = 25;
  static const double s28 = 28;
  static const double s30 = 30;
  static const double s40 = 40;
  static const double s48 = 48;
  static const double s50 = 50;
  static const double s60 = 60;
  static const double s64 = 64;
  static const double s70 = 70;
  static const double s72 = 72;
  static const double s80 = 80;
  static const double s90 = 90;
  static const double s100 = 100;
  static const double s115 = 115;
  static const double s120 = 120;
  static const double s130 = 130;
  static const double s150 = 150;
  static const double s173 = 173;
  static const double s180 = 180;
  static const double s190 = 190;
  static const double s200 = 200;
  static const double s240 = 240;
}
