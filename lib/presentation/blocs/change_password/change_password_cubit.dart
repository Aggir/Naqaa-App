import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:naqaa/app/di/dependency_injection.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/domain/usecases/change_password_usecase.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(const ChangePasswordState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode oldPasswordFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  void changePassword() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(changePasswordStatus: Status.loading));
      initChangePassword();
      (await instance<ChangePasswordUsecase>().execute(
              ChangePasswordUsecaseInput(
                  oldPassword: oldPasswordController.text,
                  newPassword: newPasswordController.text)))
          .fold(
        (failure) => emit(state.copyWith(
            changePasswordStatus: Status.failure,
            errorMessage: failure.message)),
        (data) => emit(state.copyWith(changePasswordStatus: Status.success)),
      );
    }
  }
}
