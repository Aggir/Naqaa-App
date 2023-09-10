import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/constants.dart';
import 'package:naqaa/app/enums/status_enum.dart';
import 'package:naqaa/app/functions.dart';
import 'package:naqaa/presentation/blocs/user/user_cubit.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_app_bar.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/custom_toast.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';
import 'package:naqaa/presentation/widgets/primary_button.dart';
import 'package:naqaa/presentation/widgets/secondary_button.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<UserCubit>(context);
    return Scaffold(
      appBar: CustomAppBar.basic(title: ''),
      body: PageContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              capitalizeAllWord(AppStrings.verifyYourEmail.tr()),
              style: boldBlackHugeStyle(),
            ),
            CustomSpacers.mediumLarge(),
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return Text.rich(
                  TextSpan(
                    text: AppStrings.yourEmail.tr(),
                    style: regularGrayStyle(),
                    children: [
                      TextSpan(
                        text: state.user?.email ?? Constants.empty,
                        style: semiGrayStyle(),
                      ),
                      TextSpan(text: AppStrings.hasNotBeenVerifiedYet.tr())
                    ],
                  ),
                );
              },
            ),
            CustomSpacers.large(),
            PrimaryButton.fullWidth(
              onPressed: () => cubit.signOut(),
              child: Text(
                AppStrings.iConfirmedMyEmail.tr().toUpperCase(),
              ),
            ),
            CustomSpacers.medium(),
            BlocConsumer<UserCubit, UserState>(
              listenWhen: (previous, current) =>
                  previous.sendEmailVerificationStatus !=
                  current.sendEmailVerificationStatus,
              listener: (context, state) {
                if (state.sendEmailVerificationStatus.isFailure) {
                  CustomToast.error(
                      context, state.sendEmailVerificationErrorMessage!);
                } else if (state.sendEmailVerificationStatus.isSuccess) {
                  CustomToast.success(context,
                      '${AppStrings.sendEmailVerificationSuccessMessage.tr()} ${state.user?.email}');
                }
              },
              builder: (context, state) {
                return SecondaryButton.fullWidth(
                  isLoading: state.sendEmailVerificationStatus.isLoading,
                  onPressed: () => cubit.sendEmailVerification(),
                  child: Text(
                    AppStrings.sendAgain.tr().toUpperCase(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
