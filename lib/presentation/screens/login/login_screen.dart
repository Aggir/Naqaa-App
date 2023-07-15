import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/functions.dart';
import 'package:naqaa/presentation/app_router.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/font_manager.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/connect_with_google_button.dart';
import 'package:naqaa/presentation/widgets/pressable_text.dart';
import 'package:naqaa/presentation/widgets/primary_button.dart';

import '../../widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _forgotPasswordHandler(BuildContext context) {
    context.push(Routes.forgotPasswordRoute);
  }

  void _signInHandler() {}

  void _createAccountHandler(BuildContext context) {
    context.push(Routes.signUpRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(capitalizeAllWord(AppStrings.getStarted.tr())),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: AppValues.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              extraLargeSpacing(),
              SvgPicture.asset(
                SvgAssets.fullLogo,
                height: 173,
                width: 115,
              ),
              largeSpacing(),
              Text(
                AppStrings.loginScreenDescription.tr(),
                style: descriptionTextStyle(),
                textAlign: TextAlign.center,
              ),
              largeSpacing(),
              const ConnectWithGoogleButton(),
              mediumSpacing(),
              Text(
                AppStrings.or.tr(),
                style: descriptionTextStyle(),
              ),
              mediumSpacing(),
              Form(
                child: Column(
                  children: [
                    CustomTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      hintText: AppStrings.emailAddress.tr(),
                      suffixIcon: SvgPicture.asset(SvgAssets.envelope),
                    ),
                    mediumSpacing(),
                    CustomTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      hintText: AppStrings.password.tr(),
                      isPassword: true,
                    ),
                  ],
                ),
              ),
              smallSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PressableText(
                    onTap: () => _forgotPasswordHandler(context),
                    text: AppStrings.forgotPasswordQuestion.tr(),
                    fontSize: FontSize.s12,
                  ),
                ],
              ),
              largeSpacing(),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  onPressed: _signInHandler,
                  child: Text(
                    AppStrings.signIn.tr().toUpperCase(),
                  ),
                ),
              ),
              mediumSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${AppStrings.doNotHaveAnAccount.tr()} ',
                    style: bodySmallGrayTextStyle(),
                  ),
                  PressableText(
                    onTap: () => _createAccountHandler(context),
                    text: AppStrings.createOneHere.tr(),
                    fontSize: FontSize.s12,
                    fontWeight: FontWeight.bold,
                  )
                ],
              )
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
