import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/app/validators.dart';
import 'package:naqaa/presentation/blocs/sign_up/sign_up_cubit.dart';

import 'package:naqaa/presentation/widgets/custom_back_button.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/custom_toast.dart';
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

  void _signUpHandler(BuildContext context) {
    BlocProvider.of<SignUpCubit>(context).signUp();
  }

  void _termsOfUseHandler(BuildContext context) {}

  void _privacyAndPolicyHandler(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: AppValues.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSpacers.extraLarge(),
              Text(
                capitalizeAllWord(AppStrings.createAccount.tr()),
                style: headlineTextStyle(),
              ),
              CustomSpacers.large(),
              Text(
                AppStrings.signUpScreenDescription.tr(),
                style: bodyMediumTextStyle(),
              ),
              PressableText(
                text: AppStrings.alreadyHaveAnAccount.tr(),
                onTap: () => context.pop(),
                fontWeight: FontWeight.w600,
              ),
              CustomSpacers.large(),
              Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: cubit.fullNameController,
                      keyboardType: TextInputType.name,
                      hintText: AppStrings.fullName.tr(),
                    ),
                    CustomSpacers.medium(),
                    CustomTextFormField(
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: AppStrings.emailAddress.tr(),
                      suffixIcon: SvgPicture.asset(SvgAssets.envelope),
                      validator: emailValidator,
                    ),
                    CustomSpacers.medium(),
                    CustomTextFormField(
                      controller: cubit.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: AppStrings.password.tr(),
                      isPassword: true,
                      validator: (value) =>
                          passwordMatchesTheConfirmationValidator(
                              value, cubit.confirmPasswordController.text),
                    ),
                    CustomSpacers.medium(),
                    CustomTextFormField(
                      controller: cubit.confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: AppStrings.reenterPassword.tr(),
                      isPassword: true,
                      validator: (value) =>
                          confirmPasswordMatchesPasswordValidator(
                              value, cubit.passwordController.text),
                    ),
                  ],
                ),
              ),
              CustomSpacers.medium(),
              BlocConsumer<SignUpCubit, SignUpState>(
                listener: (context, state) {
                  if (state.signUpStatus.isFailure) {
                    CustomToast.error(context, state.errorMessage!);
                  }
                },
                builder: (context, state) {
                  return PrimaryButton.fullWidth(
                    onPressed: () => _signUpHandler(context),
                    isLoading: state.signUpStatus.isLoading,
                    child: Text(
                      AppStrings.signUp.tr().toUpperCase(),
                    ),
                  );
                },
              ),
              CustomSpacers.medium(),
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
                          onTap: () => _termsOfUseHandler(context),
                        ),
                        Text(
                          ' & ',
                          style: bodyMediumTextStyle(),
                        ),
                        PressableText(
                          text: AppStrings.privacyAndPolicy.tr(),
                          onTap: () => _privacyAndPolicyHandler(context),
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
              CustomSpacers.medium(),
              Center(
                child: Text(
                  AppStrings.or.tr(),
                  style: descriptionTextStyle(),
                ),
              ),
              CustomSpacers.medium(),
              const ConnectWithGoogleButton(),
              CustomSpacers.medium(),
            ],
          ),
        ),
      ),
    );
  }
}
