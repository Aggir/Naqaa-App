import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:naqaa/app/di/dependency_injection.dart';
import 'package:naqaa/app/enum.dart';
import '../../../domain/usecases/send_reset_instructions_usecase.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(const ForgotPasswordState());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailAddressController = TextEditingController();

  sendResetInstructions() async {
    if (formKey.currentState!.validate()) {
      initSendResetInstructions();
      emit(state.copyWith(sendResetInstructionsStatus: Status.loading));
      (await instance<SendResetInstructionsUsecase>()
              .execute(emailAddressController.text))
          .fold((failure) {
        emit(state.copyWith(
            sendResetInstructionsStatus: Status.failure,
            errorMessage: failure.message));
      }, (data) {
        emit(state.copyWith(sendResetInstructionsStatus: Status.success));
      });
    }
  }
}
