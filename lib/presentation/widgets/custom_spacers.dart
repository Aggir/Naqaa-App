import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_theme.dart';

class CustomSpacers {
  static Widget extraLarge() {
    return SizedBox(
      height: AppValues.extraLarge.r,
      width: AppValues.extraLarge.r,
    );
  }

  static Widget large() {
    return SizedBox(
      height: AppValues.large.r,
      width: AppValues.large.r,
    );
  }

  static Widget mediumLarge() {
    return SizedBox(
      height: AppValues.mediumLarge.r,
      width: AppValues.mediumLarge.r,
    );
  }

  static Widget medium() {
    return SizedBox(
      height: AppValues.medium.r,
      width: AppValues.medium.r,
    );
  }

  static Widget mediumSmall() {
    return SizedBox(
      height: AppValues.mediumSmall.r,
      width: AppValues.mediumSmall.r,
    );
  }

  static Widget small() {
    return SizedBox(
      height: AppValues.small.r,
      width: AppValues.small.r,
    );
  }

  static Widget extraSmall() {
    return SizedBox(
      height: AppValues.extraSmall.r,
      width: AppValues.extraSmall.r,
    );
  }
}
