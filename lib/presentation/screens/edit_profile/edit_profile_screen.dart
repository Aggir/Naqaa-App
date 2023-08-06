import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/presentation/blocs/edit_profile/edit_profile_cubit.dart';
import 'package:naqaa/presentation/widgets/custom_drop_down_field.dart';
import 'package:naqaa/presentation/widgets/custom_form_field_date_picker.dart';
import 'package:naqaa/presentation/widgets/custom_text_form_field.dart';
import 'package:naqaa/presentation/widgets/custom_toast.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';
import 'package:naqaa/presentation/widgets/primary_button.dart';

import '../../../app/app_strings.dart';
import '../../../app/constants.dart';
import '../../blocs/auth/auth_cubit.dart';
import '../../theme/app_theme.dart';
import '../../theme/text_style_manager.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_spacers.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  void _saveButtonFunction(BuildContext context) {
    final cubit = BlocProvider.of<EditProfileCubit>(context);
    if (cubit.isFormValid) {
      BlocProvider.of<AuthCubit>(context).editProfile(cubit.nameController.text,
          cubit.genderController.text, cubit.dateOfBirthController.text);
    }
  }

  String? value;
  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<EditProfileCubit>(context);
    value = cubit.gender.isEmpty ? null : cubit.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.basic(
          title: AppStrings.settings.tr(),
          backButton: () {
            context.go(AppScreen.settings.toPath);
          }),
      body: PageContainer(
          child: Column(
        children: [
          // CustomSpacers.large(),
          _profilePicture(),
          CustomSpacers.large(),
          _form(context),
          CustomSpacers.large(),
          BlocConsumer<AuthCubit, AuthState>(
            listenWhen: (previous, current) =>
                current.editProfileStatus != previous.editProfileStatus,
            listener: (context, state) {
              if (state.editProfileStatus.isFailure) {
                CustomToast.error(context, state.authErrorMessage!);
              } else if (state.editProfileStatus.isSuccess) {
                CustomToast.success(
                    context, AppStrings.editProfileSuccessMessage.tr());
              }
            },
            builder: (context, state) {
              return PrimaryButton.fullWidth(
                isLoading: state.editProfileStatus.isLoading,
                onPressed: () => _saveButtonFunction(context),
                child: Text(AppStrings.save.tr().toUpperCase()),
              );
            },
          )
        ],
      )),
    );
  }

  Widget _profilePicture() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return CircleAvatar(
          radius: AppSizes.s45,
          foregroundImage: state.user?.profilePictureUrl.isNotEmpty ?? false
              ? NetworkImage(state.user!.profilePictureUrl)
              : null,
          child: state.user?.profilePictureUrl.isEmpty ?? false
              ? Text(
                  (state.user?.name[0] ?? Constants.empty).toUpperCase(),
                  style: boldWhiteHugeStyle(),
                )
              : null,
        );
      },
    );
  }

  Widget _form(BuildContext context) {
    final cubit = BlocProvider.of<EditProfileCubit>(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.email.tr(),
                  style: regularBlackStyle(),
                ),
                CustomSpacers.extraSmall(),
                CustomTextFormField(
                  controller: cubit.emailController,
                  enabled: false,
                ),
                CustomSpacers.medium(),
                Text(
                  AppStrings.name.tr(),
                  style: regularBlackStyle(),
                ),
                CustomSpacers.extraSmall(),
                CustomTextFormField(
                  controller: cubit.nameController,
                ),
                CustomSpacers.medium(),
                Text(
                  AppStrings.gender.tr(),
                  style: regularBlackStyle(),
                ),
                CustomSpacers.extraSmall(),
                CustomDropDownField(
                  defaultValidator: false,
                  hintText: AppStrings.genderFieldHint.tr(),
                  focusedStyleEnabled: false,
                  value: value,
                  onChanged: (v) {
                    cubit.genderController.text = v;
                    setState(() {
                      value = v;
                    });
                  },
                  items: Constants.genders
                      .map(
                        (gender) => DropdownMenuItem(
                          value: gender.id,
                          child: Text(
                            gender.name.tr(),
                            style: regularBlackStyle(),
                          ),
                        ),
                      )
                      .toList(),
                ),
                CustomSpacers.medium(),
                Text(
                  AppStrings.dateOfBirth.tr(),
                  style: regularBlackStyle(),
                ),
                CustomSpacers.extraSmall(),
                CustomFormFieldDatePicker(
                  defaultValidator: false,
                  hintText: AppStrings.dateOfBirthFieldHint.tr(),
                  focusedStyleEnabled: false,
                  controller: cubit.dateOfBirthController,
                ),
              ],
            ));
      },
    );
  }
}
