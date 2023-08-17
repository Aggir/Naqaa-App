import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_back_button.dart';

import '../../app/app_strings.dart';

class CustomAppBar {
  static AppBar basic(
          {String? title,
          void Function()? backButton,
          List<Widget>? actions}) =>
      AppBar(
        title: Text(
          (title ?? AppStrings.noRouteFound.tr()).toUpperCase(),
          style: semiBlackStyle(),
        ),
        actions: actions,
        leading: backButton != null
            ? CustomBackButton(
                onTap: backButton,
              )
            : null,
      );
}
