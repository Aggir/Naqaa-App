import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:naqaa/app/di/dependency_injection.dart';
import 'package:naqaa/domain/usecases/index.dart';

import '../../../app/enum.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void signUp() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(signUpStatus: Status.loading));
      initSignUp();
      (await instance<SignUpUsecase>().execute(SignUpUsecaseInput(
        fullName: fullNameController.text,
        emailAddress: emailController.text,
        password: passwordController.text,
      )))
          .fold(
        (failure) {
          emit(state.copyWith(
            signUpStatus: Status.failure,
            errorMessage: failure.message,
          ));
        },
        (data) {
          emit(state.copyWith(signUpStatus: Status.success));
        },
      );
    }
  }
}
