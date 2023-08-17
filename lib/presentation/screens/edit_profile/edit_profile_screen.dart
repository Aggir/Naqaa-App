import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/app/extensions.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/presentation/blocs/edit_profile/edit_profile_cubit.dart';
import 'package:naqaa/presentation/screens/edit_profile/components/image_picker_bottom_sheet.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/widgets/custom_drop_down_field.dart';
import 'package:naqaa/presentation/widgets/custom_form_field_date_picker.dart';
import 'package:naqaa/presentation/widgets/custom_text_form_field.dart';
import 'package:naqaa/presentation/widgets/custom_toast.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';
import 'package:naqaa/presentation/widgets/primary_button.dart';

import '../../../app/app_strings.dart';
import '../../../app/constants.dart';
import '../../blocs/user/user_cubit.dart';
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
  void _saveButtonFunction(BuildContext context, UserState state) {
    final cubit = BlocProvider.of<EditProfileCubit>(context);
    if (cubit.isFormValid) {
      BlocProvider.of<UserCubit>(context).editProfile(
          state.user!.copyWith(
            name: cubit.name,
            genderId: cubit.gender,
            dateOfBirth: cubit.dateOfBirth.asNullableDate,
          ),
          pickedImage:
              BlocProvider.of<EditProfileCubit>(context).state.selectedPicture);
    }
  }

  _editProfilePhotoFunction(BuildContext context) async {
    BlocProvider.of<EditProfileCubit>(context).imagePickerMode(
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (bottomSheetContext) => const ImagePickerBottomSheet(),
      ),
    );
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
          _profilePicture(context),
          CustomSpacers.large(),
          _form(context),
          CustomSpacers.large(),
          BlocConsumer<UserCubit, UserState>(
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
                onPressed: () => _saveButtonFunction(context, state),
                child: Text(AppStrings.save.tr().toUpperCase()),
              );
            },
          )
        ],
      )),
    );
  }

  Widget? getProfilePictureWidget(
    EditProfileState editState,
    UserState userState,
  ) {
    if (editState.selectedPicture != null) {
      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppValues.circleRadius)),
        height: AppSizes.s120.r,
        width: AppSizes.s120.r,
        child: Image.file(
          editState.selectedPicture!,
          fit: BoxFit.fitWidth,
        ),
      );
    } else if (userState.user?.profilePictureUrl.isNotEmpty ?? false) {
      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppValues.circleRadius)),
        height: AppSizes.s120.r,
        width: AppSizes.s120.r,
        child: userState.user != null
            ? CachedNetworkImage(
                placeholder: (context, url) => SizedBox(
                  width: AppSizes.s20.r,
                  height: AppSizes.s20.r,
                  child: CircularProgressIndicator(
                    color: AppColors.snowWhite,
                  ),
                ),
                imageUrl: userState.user!.profilePictureUrl,
                fit: BoxFit.fitWidth,
              )
            : null,
      );
    } else {
      return null;
    }
  }

  Widget _profilePicture(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, editState) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: AppSizes.s45.r,
                  child: state.user?.profilePictureUrl.isEmpty ?? false
                      ? Text(
                          (state.user?.name[0] ?? Constants.empty)
                              .toUpperCase(),
                          style: boldWhiteHugeStyle(),
                        )
                      : getProfilePictureWidget(editState, state),
                ),
                // Todo: RTL / LTR
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                    height: AppSizes.s30.r,
                    width: AppSizes.s30.r,
                    child: Material(
                      borderRadius:
                          BorderRadius.circular(AppValues.circleRadius),
                      clipBehavior: Clip.antiAlias,
                      color: AppColors.primary,
                      child: InkWell(
                        onTap: () => _editProfilePhotoFunction(context),
                        child: SvgPicture.asset(
                          SvgAssets.pen,
                          height: AppSizes.s14.r,
                          width: AppSizes.s14.r,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _form(BuildContext context) {
    final cubit = BlocProvider.of<EditProfileCubit>(context);
    return BlocBuilder<UserCubit, UserState>(
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
