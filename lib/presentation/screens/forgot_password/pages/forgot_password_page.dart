import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/app/validators.dart';
import 'package:naqaa/presentation/blocs/forgot_password/forgot_password_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/custom_toast.dart';

import '../../../../app/functions.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/primary_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  void _sendResetInstructionsHandler(BuildContext context) {
    FocusScope.of(context).unfocus();
    BlocProvider.of<ForgotPasswordCubit>(context).sendResetInstructions();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ForgotPasswordCubit>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: AppValues.large).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSpacers.extraLarge(),
              Text(
                capitalizeAllWord(AppStrings.forgotPassword.tr()),
                style: boldBlackHugeStyle(),
              ),
              CustomSpacers.mediumLarge(),
              Text(
                AppStrings.signUpScreenDescription.tr(),
                style: regularGrayStyle(),
              ),
              CustomSpacers.large(),
              Form(
                key: cubit.formKey,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: cubit.emailAddressController,
                  validator: emailValidator,
                  decoration: InputDecoration(
                    labelText: AppStrings.emailAddress.tr(),
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) =>
                      _sendResetInstructionsHandler(context),
                ),
              ),
              CustomSpacers.large(),
              BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                listener: (context, state) {
                  if (state.sendResetInstructionsStatus.isFailure) {
                    CustomToast.error(context, state.errorMessage!);
                  } else if (state.sendResetInstructionsStatus.isSuccess) {
                    context.go(AppScreen.forgotPasswordInstructionsSent.toPath);
                  }
                },
                builder: (context, state) {
                  return PrimaryButton.fullWidth(
                    isLoading: state.sendResetInstructionsStatus.isLoading,
                    onPressed: () => _sendResetInstructionsHandler(context),
                    child: Text(
                      AppStrings.sendResetInstructions.tr().toUpperCase(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
