import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/data/datasources/remote_datasource.dart';
import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/data/responses/responses.dart';

import 'firebase_auth_error_handler.dart';

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
  Future<SignInResponse> connectWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser != null) {
        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: gAuth.accessToken, idToken: gAuth.idToken);
        await _firebaseAuth.signInWithCredential(credential);
        return const SignInResponse(
            Status.success, "Debug: sign-in with Google success response");
      }
    } on FirebaseAuthException catch (e) {
      return SignInResponse(
          Status.failure, FirebaseAuthErrorHandler.getAuthErrorMessage(e));
    } catch (e) {
      return SignInResponse(Status.failure, e.toString());
    }
    return const SignInResponse(
        Status.canceled, "Debug: sign-in with Google canceled response");
  }

  @override
  Future<SignOutResponse> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return SignOutResponse(
          Status.failure, FirebaseAuthErrorHandler.getAuthErrorMessage(e));
    } catch (e) {
      return SignOutResponse(Status.failure, e.toString());
    }
    return const SignOutResponse(
        Status.success, "Debug: sign-out success response");
  }

  @override
  Future<SignUpResponse> signUp(SignUpRequest request) async {
    try {
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
