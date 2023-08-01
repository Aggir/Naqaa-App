import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/data/datasources/remote_datasource.dart';
import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/data/responses/responses.dart';

class FirebaseApi implements RemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  const FirebaseApi(this._firebaseAuth);

  @override
  Future<ResetPasswordInstructionsResponse> sendResetPasswordInstructions(
      SendResetPasswordInstructionsRequest request) async {
    try {
      // Todo: add url to navigate you from reset password web page to the app.
      await _firebaseAuth.sendPasswordResetEmail(email: request.emailAddress);
    } on FirebaseAuthException catch (e) {
      return ResetPasswordInstructionsResponse(Status.failure,
          FirebaseAuthErrorHandler.getResetPasswordErrorMessage(e));
    } catch (e) {
      return ResetPasswordInstructionsResponse(Status.failure, e.toString());
    }
    return ResetPasswordInstructionsResponse(
        Status.success, AppStrings.sendResetInstructionsSuccessMessage.tr());
  }

  @override
  Future<SignInResponse> signIn(SignInRequest request) async {
    try {
      // UserCredential userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
          email: request.emailAddress, password: request.password);
    } on FirebaseAuthException catch (e) {
      return SignInResponse(
          Status.failure, FirebaseAuthErrorHandler.getAuthErrorMessage(e));
    } catch (e) {
      return SignInResponse(Status.failure, e.toString());
    }
    return const SignInResponse(
        Status.success, "Debug: sign-in success response");
  }

  @override
  Future<SignUpResponse> signUp(SignUpRequest request) async {
    try {
      // final UserCredential userCredential =
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: request.emailAddress,
        password: request.password,
      );
    } on FirebaseAuthException catch (e) {
      return SignUpResponse(
          Status.failure, FirebaseAuthErrorHandler.getAuthErrorMessage(e));
    } catch (e) {
      return SignUpResponse(Status.failure, e.toString());
    }
    return const SignUpResponse(
        Status.success, "Debug: sign-up success response");
  }
}

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
}
