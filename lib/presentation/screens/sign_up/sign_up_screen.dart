import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naqaa/presentation/widgets/pressable_text.dart';

import '../../../app/app_strings.dart';
import '../../../app/assets_manager.dart';
import '../../../app/functions.dart';
import '../../theme/app_theme.dart';
import '../../theme/text_style_manager.dart';
import '../../widgets/connect_with_google_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/primary_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              extraLargeSpacing(),
              Text(
                capitalizeAllWord(AppStrings.createAccount.tr()),
                style: headlineTextStyle(),
              ),
              largeSpacing(),
              Text(
                AppStrings.signUpScreenDescription.tr(),
                style: bodyMediumTextStyle(),
              ),
              PressableText(
                text: AppStrings.alreadyHaveAnAccount.tr(),
                onTap: () {},
                fontWeight: FontWeight.w600,
              ),
              largeSpacing(),
              Form(
                child: Column(
                  children: [
                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      hintText: AppStrings.fullName.tr(),
                    ),
                    mediumSpacing(),
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
                    mediumSpacing(),
                    CustomTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      hintText: AppStrings.reenterPassword.tr(),
                      isPassword: true,
                    ),
                  ],
                ),
              ),
              mediumSpacing(),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.signUp.tr().toUpperCase(),
                  ),
                ),
              ),
              mediumSpacing(),
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.bySigningUpYouAgreeToOur.tr(),
                      style: bodyMediumTextStyle(),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PressableText(
                          text: AppStrings.termsOfUse.tr(),
                          onTap: () {},
                        ),
                        Text(
                          ' & ',
                          style: bodyMediumTextStyle(),
                        ),
                        PressableText(
                          text: AppStrings.privacyAndPolicy.tr(),
                          onTap: () {},
                        ),
                        Text(
                          '.',
                          style: bodyMediumTextStyle(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              mediumSpacing(),
              Center(
                child: Text(
                  AppStrings.or.tr(),
                  style: descriptionTextStyle(),
                ),
              ),
              mediumSpacing(),
              const ConnectWithGoogleButton(),
              mediumSpacing(),
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
