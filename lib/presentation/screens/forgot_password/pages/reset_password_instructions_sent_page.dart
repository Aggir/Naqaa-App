import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/presentation/widgets/pressable_text.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/functions.dart';
import '../../../blocs/forgot_password/forgot_password_cubit.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/font_manager.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/custom_toast.dart';
import '../../../widgets/primary_button.dart';

class ResetPasswordInstructionsSentScreen extends StatelessWidget {
  const ResetPasswordInstructionsSentScreen({super.key});

  void _sendAgainFunction(BuildContext context) {
    BlocProvider.of<ForgotPasswordCubit>(context).sendResetInstructions();
  }

  void _havingAProblemFunction(context) {}

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ForgotPasswordCubit>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.large).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSpacers.extraLarge(),
            Text(
              capitalizeAllWord(AppStrings.forgotPassword.tr()),
              style: headlineTextStyle(),
            ),
            CustomSpacers.mediumLarge(),
            Wrap(
              children: [
                Text(
                  AppStrings.weHaveSentTheInstructionsEmailTo.tr(),
                  style: regularGrayStyle(),
                ),
                Text(
                  '${cubit.emailAddressController.text}.',
                  style: semiGrayStyle(),
                ),
              ],
            ),
            PressableText(
                text: AppStrings.havingAProblem.tr(),
                onTap: () => _havingAProblemFunction(context),
                fontWeight: FontWeight.w600),
            CustomSpacers.large(),
            BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
              listener: (context, state) {
                if (state.sendResetInstructionsStatus.isFailure) {
                  CustomToast.error(context, state.errorMessage!);
                } else if (state.sendResetInstructionsStatus.isSuccess) {
                  CustomToast.success(context,
                      '${AppStrings.sendResetInstructionsSuccessMessage.tr()} ${cubit.emailAddressController.text}');
                }
              },
              builder: (context, state) {
                return PrimaryButton.fullWidth(
                  isLoading: state.sendResetInstructionsStatus.isLoading,
                  onPressed: () => _sendAgainFunction(context),
                  child: Text(
                    AppStrings.sendAgain.tr().toUpperCase(),
                  ),
                );
              },
            ),
            CustomSpacers.mediumLarge(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${AppStrings.didNotReceiveInstructions.tr()} ',
                  style: bodySmallGrayTextStyle(),
                ),
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  builder: (context, state) {
                    return PressableText(
                      onTap: state.sendResetInstructionsStatus.isLoading
                          ? null
                          : () => _sendAgainFunction(context),
                      text: '${AppStrings.sendAgain.tr()}.',
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.bold,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
