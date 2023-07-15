import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/presentation/widgets/custom_back_button.dart';

import '../../../app/functions.dart';
import '../../theme/app_theme.dart';
import '../../theme/text_style_manager.dart';
import '../../widgets/primary_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  void _sendResetInstructionsHandler() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(AppStrings.getStarted.tr()),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: AppValues.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              extraLargeSpacing(),
              Text(
                capitalizeAllWord(AppStrings.forgotPassword.tr()),
                style: headlineTextStyle(),
              ),
              largeSpacing(),
              Text(
                AppStrings.signUpScreenDescription.tr(),
                style: bodyMediumTextStyle(),
              ),
              largeSpacing(),
              Form(
                  child: TextFormField(
                decoration:
                    InputDecoration(labelText: AppStrings.emailAddress.tr()),
              )),
              largeSpacing(),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  onPressed: _sendResetInstructionsHandler,
                  child: Text(
                    AppStrings.sendResetInstructions.tr().toUpperCase(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget extraLargeSpacing() {
    return const SizedBox(
      height: AppSizes.s40,
      width: AppSizes.s40,
    );
  }

  Widget largeSpacing() {
    return const SizedBox(
      height: AppValues.large,
      width: AppValues.large,
    );
  }

  Widget mediumSpacing() {
    return const SizedBox(
      height: AppValues.medium,
      width: AppValues.medium,
    );
  }

  Widget smallSpacing() {
    return const SizedBox(
      height: AppValues.small,
      width: AppValues.small,
    );
  }
}
