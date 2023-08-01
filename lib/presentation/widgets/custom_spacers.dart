import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CustomSpacers {
  static Widget extraLarge() {
    return const SizedBox(
      height: AppValues.extraLarge,
      width: AppValues.extraLarge,
    );
  }

  static Widget large() {
    return const SizedBox(
      height: AppValues.large,
      width: AppValues.large,
    );
  }

  static Widget mediumLarge() {
    return const SizedBox(
      height: AppValues.mediumLarge,
      width: AppValues.mediumLarge,
    );
  }

  static Widget medium() {
    return const SizedBox(
      height: AppValues.medium,
      width: AppValues.medium,
    );
  }

  static Widget mediumSmall() {
    return const SizedBox(
      height: AppValues.mediumSmall,
      width: AppValues.mediumSmall,
    );
  }

  static Widget small() {
    return const SizedBox(
      height: AppValues.small,
      width: AppValues.small,
    );
  }

  static Widget extraSmall() {
    return const SizedBox(
      height: AppValues.extraSmall,
      width: AppValues.extraSmall,
    );
  }
}
