import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../app/app_strings.dart';

class FirebaseAuthErrorHandler {
  static String getAuthErrorMessage(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'weak-password':
        return AppStrings.weakPassword.tr();
      case 'email-already-in-use':
        return AppStrings.emailAlreadyInUse.tr();
      case 'invalid-email':
        return AppStrings.invalidEmail.tr();
      case 'user-not-found':
        return AppStrings.invalidCredential.tr();
      case 'wrong-password':
        return AppStrings.invalidCredential.tr();
      case 'too-many-requests':
        return AppStrings.tooManyRequests.tr();
      default:
        return AppStrings.defaultErrorMessage.tr();
    }
  }

  static String getResetPasswordErrorMessage(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return AppStrings.invalidEmail.tr();
      case 'user-not-found':
        return AppStrings.noUserFoundForThatEmail.tr();
      case 'too-many-requests':
        return AppStrings.tooManyRequests.tr();
      default:
        return AppStrings.defaultErrorMessage.tr();
    }
  }

  static String getChangePasswordErrorMessage(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'wrong-password':
        return AppStrings.wrongPassword.tr();
      case 'too-many-requests':
        return AppStrings.tooManyRequests.tr();
      default:
        return AppStrings.defaultErrorMessage.tr();
    }
  }
}
