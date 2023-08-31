import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/enums/status_enum.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/app/validators.dart';
import 'package:naqaa/presentation/blocs/change_password/change_password_cubit.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_app_bar.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/custom_text_form_field.dart';
import 'package:naqaa/presentation/widgets/custom_toast.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';
import 'package:naqaa/presentation/widgets/primary_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  void _saveNewPasswordFunction(BuildContext context) {
    _unfocusFields(context);
    BlocProvider.of<ChangePasswordCubit>(context).changePassword();
  }

  _unfocusFields(BuildContext context) {
    final cubit = BlocProvider.of<ChangePasswordCubit>(context);
    cubit.oldPasswordFocusNode.unfocus();
    cubit.newPasswordFocusNode.unfocus();
    cubit.confirmPasswordFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _unfocusFields(context),
      child: Scaffold(
          appBar: CustomAppBar.basic(
              title: AppStrings.settings.tr(),
              backButton: () {
                context.go(AppScreen.settings.toPath);
              }),
          body: PageContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.changePassword.tr(),
                  style: boldBlackExtraLargeStyle(),
                ),
                CustomSpacers.medium(),
                Text(
                  AppStrings.changePasswordDescription.tr(),
                  style: regularGrayStyle(),
                ),
                CustomSpacers.extraLarge(),
                _form(context),
                CustomSpacers.large(),
                BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                  listener: (context, state) {
                    if (state.changePasswordStatus.isFailure) {
                      CustomToast.error(context, state.errorMessage!);
                    } else if (state.changePasswordStatus.isSuccess) {
                      CustomToast.success(
                          context, AppStrings.passwordChangedSuccessfully.tr());
                    }
                  },
                  builder: (context, state) {
                    return PrimaryButton.fullWidth(
                      isLoading: state.changePasswordStatus.isLoading,
                      onPressed: () => _saveNewPasswordFunction(context),
                      child: Text(
                        AppStrings.save.tr().toUpperCase(),
                      ),
                    );
                  },
                )
              ],
            ),
          )),
    );
  }

  Widget _form(BuildContext context) {
    final cubit = BlocProvider.of<ChangePasswordCubit>(context);
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            focusNode: cubit.oldPasswordFocusNode,
            controller: cubit.oldPasswordController,
            onEditingComplete: () =>
                FocusScope.of(context).requestFocus(cubit.newPasswordFocusNode),
            hintText: AppStrings.oldPassword.tr(),
            isPassword: true,
            textInputAction: TextInputAction.next,
            validator: (value) => passwordValidator(value),
          ),
          CustomSpacers.medium(),
          CustomTextFormField(
            focusNode: cubit.newPasswordFocusNode,
            controller: cubit.newPasswordController,
            onEditingComplete: () => FocusScope.of(context)
                .requestFocus(cubit.confirmPasswordFocusNode),
            hintText: AppStrings.newPassword.tr(),
            isPassword: true,
            textInputAction: TextInputAction.next,
            validator: (value) => passwordMatchesTheConfirmationValidator(
                value, cubit.confirmPasswordController.text),
          ),
          CustomSpacers.medium(),
          CustomTextFormField(
            focusNode: cubit.confirmPasswordFocusNode,
            controller: cubit.confirmPasswordController,
            hintText: AppStrings.reenterPassword.tr(),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _saveNewPasswordFunction(context),
            isPassword: true,
            validator: (value) => confirmPasswordMatchesPasswordValidator(
                value, cubit.newPasswordController.text),
          ),
        ],
      ),
    );
  }
}
