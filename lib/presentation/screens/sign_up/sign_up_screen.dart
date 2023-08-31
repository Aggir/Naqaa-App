import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/enums/status_enum.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/app/validators.dart';
import 'package:naqaa/presentation/blocs/user/user_cubit.dart';
import 'package:naqaa/presentation/blocs/sign_up/sign_up_cubit.dart';

import 'package:naqaa/presentation/widgets/custom_back_button.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/custom_toast.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';
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
    _unFocus(context);
    final signUpCubit = BlocProvider.of<SignUpCubit>(context);
    if (signUpCubit.isFormValid) {
      BlocProvider.of<UserCubit>(context)
          .signUp(signUpCubit.name, signUpCubit.email, signUpCubit.password);
    }
  }

  void _termsOfUseHandler(BuildContext context) {
    _unFocus(context);
    context.push(AppScreen.termsOfUse.toPath);
  }

  void _privacyAndPolicyHandler(BuildContext context) {
    _unFocus(context);
    context.push(AppScreen.privacyPolicy.toPath);
  }

  void _signUpWithGoogleHandler(BuildContext context) {
    _unFocus(context);
    BlocProvider.of<UserCubit>(context).connectWithGoogle();
  }

  void _unFocus(BuildContext context) {
    BlocProvider.of<SignUpCubit>(context).confirmPasswordFocusNode.unfocus();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    return GestureDetector(
      onTap: () => _unFocus(context),
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
        ),
        body: PageContainer(
          padding:
              const EdgeInsets.symmetric(horizontal: AppValues.mediumLarge).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSpacers.large(),
              Text(
                capitalizeAllWord(AppStrings.createAccount.tr()),
                style: boldBlackHugeStyle(),
              ),
              CustomSpacers.mediumLarge(),
              Text(
                AppStrings.signUpScreenDescription.tr(),
                style: regularGrayStyle(),
              ),
              PressableText(
                text: AppStrings.alreadyHaveAnAccount.tr(),
                onTap: () => context.pop(),
                fontWeight: FontWeight.w600,
              ),
              CustomSpacers.mediumLarge(),
              Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: cubit.fullNameController,
                      keyboardType: TextInputType.name,
                      hintText: AppStrings.fullName.tr(),
                      textInputAction: TextInputAction.next,
                    ),
                    CustomSpacers.medium(),
                    CustomTextFormField(
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: AppStrings.emailAddress.tr(),
                      suffixIcon: SvgPicture.asset(SvgAssets.envelope),
                      validator: emailValidator,
                      textInputAction: TextInputAction.next,
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
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(cubit.confirmPasswordFocusNode);
                      },
                    ),
                    CustomSpacers.medium(),
                    CustomTextFormField(
                      focusNode: cubit.confirmPasswordFocusNode,
                      controller: cubit.confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: AppStrings.reenterPassword.tr(),
                      isPassword: true,
                      validator: (value) =>
                          confirmPasswordMatchesPasswordValidator(
                              value, cubit.passwordController.text),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _signUpHandler(context),
                    ),
                  ],
                ),
              ),
              CustomSpacers.medium(),
              BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  if (state.authStatus.isFailure) {
                    CustomToast.error(context, state.authErrorMessage!);
                  }
                },
                builder: (context, state) {
                  return PrimaryButton.fullWidth(
                    onPressed: () => _signUpHandler(context),
                    isLoading: state.authStatus.isLoading,
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
                      style: regularGrayStyle(),
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
                          style: regularGrayStyle(),
                        ),
                        PressableText(
                          text: AppStrings.privacyAndPolicy.tr(),
                          onTap: () => _privacyAndPolicyHandler(context),
                        ),
                        Text(
                          '.',
                          style: regularGrayStyle(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              CustomSpacers.mediumSmall(),
              Center(
                child: Text(
                  AppStrings.or.tr(),
                  style: regularBluishGrayMediumStyle(),
                ),
              ),
              CustomSpacers.mediumSmall(),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  return ConnectWithGoogleButton(
                    onPressed: () => _signUpWithGoogleHandler(context),
                    isLoading: state.authStatus.isLoading,
                  );
                },
              ),
              CustomSpacers.medium(),
            ],
          ),
        ),
      ),
    );
  }
}
