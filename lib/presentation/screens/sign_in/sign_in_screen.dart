import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/app/functions.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/app/validators.dart';
import 'package:naqaa/presentation/blocs/auth/auth_cubit.dart';
import 'package:naqaa/presentation/blocs/sign_in/sign_in_cubit.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/font_manager.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/connect_with_google_button.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/custom_toast.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';
import 'package:naqaa/presentation/widgets/pressable_text.dart';
import 'package:naqaa/presentation/widgets/primary_button.dart';

import '../../widgets/custom_text_form_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  void _forgotPasswordHandler(BuildContext context) {
    _unfocusFields(context);
    context.go(AppScreen.forgotPassword.toPath);
  }

  void _signInHandler(BuildContext context) {
    _unfocusFields(context);
    final signInCubit = BlocProvider.of<SignInCubit>(context);
    if (signInCubit.isFormValid) {
      BlocProvider.of<AuthCubit>(context).signIn(
        signInCubit.email,
        signInCubit.password,
      );
    }
  }

  void _connectWithGoogleHandler(BuildContext context) {
    _unfocusFields(context);
    BlocProvider.of<AuthCubit>(context).connectWithGoogle();
  }

  void _createAccountHandler(BuildContext context) {
    _unfocusFields(context);
    context.push(AppScreen.signUp.toPath);
  }

  void _unfocusFields(BuildContext context) {
    final cubit = BlocProvider.of<SignInCubit>(context);
    cubit.emailFocusNode.unfocus();
    cubit.passwordFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignInCubit>(context);

    return GestureDetector(
      onTap: () {
        _unfocusFields(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(capitalizeAllWord(AppStrings.getStarted.tr())),
        ),
        body: PageContainer(
          padding:
              const EdgeInsets.symmetric(horizontal: AppValues.mediumLarge).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomSpacers.large(),
              SvgPicture.asset(
                SvgAssets.fullLogo,
                height: AppSizes.s173.r,
                width: AppSizes.s115.r,
              ),
              CustomSpacers.large(),
              Text(
                AppStrings.loginScreenDescription.tr(),
                style: descriptionTextStyle(),
                textAlign: TextAlign.center,
              ),
              CustomSpacers.large(),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return ConnectWithGoogleButton(
                    onPressed: () => _connectWithGoogleHandler(context),
                    isLoading: state.authStatus.isLoading,
                  );
                },
              ),
              CustomSpacers.medium(),
              Text(
                AppStrings.or.tr(),
                style: descriptionTextStyle(),
              ),
              CustomSpacers.medium(),
              Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      focusNode: cubit.emailFocusNode,
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: AppStrings.emailAddress.tr(),
                      suffixIcon: SvgPicture.asset(SvgAssets.envelope),
                      validator: emailValidator,
                      textInputAction: TextInputAction.next,
                    ),
                    CustomSpacers.medium(),
                    CustomTextFormField(
                      focusNode: cubit.passwordFocusNode,
                      controller: cubit.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: AppStrings.password.tr(),
                      isPassword: true,
                      validator: passwordValidator,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {
                        _signInHandler(context);
                      },
                    ),
                  ],
                ),
              ),
              CustomSpacers.small(),
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
              CustomSpacers.large(),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state.authStatus.isFailure) {
                    CustomToast.error(context, state.authErrorMessage!);
                  } else if (state.authStatus.isSuccess) {
                    context.go(AppScreen.home.toPath);
                  }
                },
                builder: (context, state) {
                  return PrimaryButton.fullWidth(
                    onPressed: () => _signInHandler(context),
                    isLoading: state.authStatus.isLoading,
                    child: Text(AppStrings.signIn.tr().toUpperCase()),
                  );
                },
              ),
              CustomSpacers.medium(),
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
