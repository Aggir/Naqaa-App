import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:naqaa/app/di/dependency_injection.dart';

import 'package:naqaa/domain/entities/user.dart';
import 'package:naqaa/domain/usecases/check_email_verification_usecase.dart';
import 'package:naqaa/domain/usecases/connect_with_google_usecase.dart';
import 'package:naqaa/domain/usecases/edit_profile_usecase.dart';
import 'package:naqaa/domain/usecases/index.dart';
import 'package:naqaa/domain/usecases/is_signed_in_usecase.dart';
import 'package:naqaa/domain/usecases/send_email_verification_usecase.dart';
import 'package:naqaa/domain/usecases/sign_out_usecase.dart';

import '../../../app/enums/status_enum.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  onAppStart() async {
    initIsSignedIn();
    (await instance<IsSignedInUsecase>().execute(null)).fold(
      (l) => emit(state.copyWith(user: null, authStatus: Status.initial)),
      (r) => emit(state.copyWith(user: r, authStatus: Status.success)),
    );
  }

  signOut() async {
    initSignOut();
    await instance<SignOutUsecase>().execute(null);
    emit(const UserState());
  }

  void signIn(String email, String password) async {
    emit(state.copyWith(authStatus: Status.loading));
    initSignIn();
    (await instance<SignInUsecase>().execute(
            SignInUsecaseInput(emailAddress: email, password: password)))
        .fold(
      (failure) {
        emit(state.copyWith(
          authStatus: Status.failure,
          authErrorMessage: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(authStatus: Status.success, user: data));
      },
    );
  }

  void connectWithGoogle() async {
    emit(state.copyWith(authStatus: Status.loading));
    initConnectWithGoogle();
    (await instance<ConnectWithGoogleUsecase>().execute(null)).fold(
      (failure) {
        emit(state.copyWith(
          authStatus: Status.failure,
          authErrorMessage: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(authStatus: Status.success, user: data));
      },
    );
  }

  void signUp(String name, String email, String password) async {
    emit(state.copyWith(authStatus: Status.loading));
    initSignUp();
    (await instance<SignUpUsecase>().execute(SignUpUsecaseInput(
      fullName: name,
      emailAddress: email,
      password: password,
    )))
        .fold(
      (failure) {
        emit(state.copyWith(
          authStatus: Status.failure,
          authErrorMessage: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          user: data,
          authStatus: Status.success,
        ));
      },
    );
  }

  void sendEmailVerification() async {
    if (state.user != null) {
      emit(state.copyWith(sendEmailVerificationStatus: Status.loading));
      initSendEmailVerification();
      (await instance<SendEmailVerificationUsecase>()
              .execute(state.user!.email))
          .fold(
        (failure) => emit(state.copyWith(
          sendEmailVerificationStatus: Status.failure,
          sendEmailVerificationErrorMessage: failure.message,
        )),
        (_) => emit(state.copyWith(
          sendEmailVerificationStatus: Status.success,
        )),
      );
    }
  }

  void checkEmailVerification() async {
    if (state.user != null) {
      emit(state.copyWith(checkEmailVerificationStatus: Status.loading));
      initCheckEmailVerification();
      (await instance<CheckEmailVerificationUsecase>()
              .execute(state.user!.email))
          .fold(
        (failure) => emit(state.copyWith(
          checkEmailVerificationStatus: Status.failure,
          checkEmailVerificationErrorMessage: failure.message,
        )),
        (isEmailVerified) => emit(state.copyWith(
          checkEmailVerificationStatus: Status.success,
          isEmailVerified: isEmailVerified,
        )),
      );
    }
  }

  void editProfile(UserEntity newUser, {File? pickedImage}) async {
    emit(state.copyWith(editProfileStatus: Status.loading));
    initEditProfile();
    (await instance<EditProfileUsecase>().execute(EditProfileUsecaseInput(
            newUser: newUser, pickedImage: pickedImage)))
        .fold(
      (failure) {
        emit(state.copyWith(
          editProfileStatus: state.authStatus,
          editProfileErrorMessage: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          user: data,
          editProfileStatus: Status.success,
        ));
      },
    );
  }
}
