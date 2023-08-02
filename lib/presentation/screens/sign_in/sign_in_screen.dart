import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/app/functions.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/app/validators.dart';
import 'package:naqaa/presentation/blocs/sign_in/sign_in_cubit.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/font_manager.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/connect_with_google_button.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/custom_toast.dart';
import 'package:naqaa/presentation/widgets/pressable_text.dart';
import 'package:naqaa/presentation/widgets/primary_button.dart';

import '../../widgets/custom_text_form_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  void _forgotPasswordHandler(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.go(AppScreen.forgotPassword.toPath);
  }

  void _signInHandler(BuildContext context) {
    FocusScope.of(context).unfocus();
    BlocProvider.of<SignInCubit>(context).signIn();
  }

  void _connectWithGoogleHandler(BuildContext context) {
    FocusScope.of(context).unfocus();
    BlocProvider.of<SignInCubit>(context).connectWithGoogle();
  }

  void _createAccountHandler(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.push(AppScreen.signUp.toPath);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignInCubit>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                CustomSpacers.extraLarge(),
                SvgPicture.asset(
                  SvgAssets.fullLogo,
                  height: AppSizes.s173,
                  width: AppSizes.s115,
                ),
                CustomSpacers.large(),
                Text(
                  AppStrings.loginScreenDescription.tr(),
                  style: descriptionTextStyle(),
                  textAlign: TextAlign.center,
                ),
                CustomSpacers.large(),
                BlocBuilder<SignInCubit, SignInState>(
                  builder: (context, state) {
                    return ConnectWithGoogleButton(
                      onPressed: () => _connectWithGoogleHandler(context),
                      isLoading: state.signInStatus.isLoading,
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
                BlocConsumer<SignInCubit, SignInState>(
                  listener: (context, state) {
                    if (state.signInStatus.isFailure) {
                      CustomToast.error(context, state.errorMessage!);
                    } else if (state.signInStatus.isSuccess) {
                      context.go(AppScreen.home.toPath);
                    }
                  },
                  builder: (context, state) {
                    return PrimaryButton.fullWidth(
                      onPressed: () => _signInHandler(context),
                      isLoading: state.signInStatus.isLoading,
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
      ),
    );
  }
}
