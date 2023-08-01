import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:naqaa/app/dependency_injection.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/domain/usecases/index.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signIn() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(signInStatus: Status.loading));
      initSignIn();
      (await instance<SignInUsecase>().execute(SignInUsecaseInput(
              emailAddress: emailController.text,
              password: passwordController.text)))
          .fold(
        (failure) {
          emit(state.copyWith(
            signInStatus: Status.failure,
            errorMessage: failure.message,
          ));
        },
        (data) {
          emit(state.copyWith(signInStatus: Status.success));
        },
      );
    }
  }
}
