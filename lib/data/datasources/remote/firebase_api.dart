import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/data/datasources/remote_datasource.dart';
import 'package:naqaa/data/models/user.dart';
import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/data/responses/firebase_responses.dart';

import 'firebase_auth_error_handler.dart';

class FirebaseApi implements RemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  const FirebaseApi(this._firebaseAuth, this._firebaseFirestore);

  @override
  Future<FirebaseBasicResponse> sendResetPasswordInstructions(
      SendResetPasswordInstructionsRequest request) async {
    try {
      // Todo: add url to navigate you from reset password web page to the app.
      await _firebaseAuth.sendPasswordResetEmail(email: request.emailAddress);
    } on FirebaseAuthException catch (e) {
      return FirebaseBasicResponse(Status.failure,
          FirebaseAuthErrorHandler.getResetPasswordErrorMessage(e));
    } catch (e) {
      return FirebaseBasicResponse(Status.failure, e.toString());
    }
    return FirebaseBasicResponse(
        Status.success, AppStrings.sendResetInstructionsSuccessMessage.tr());
  }

  @override
  Future<FirebaseAuthResponse> signIn(SignInRequest request) async {
    User? user;
    try {
      user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: request.emailAddress, password: request.password))
          .user;
      UserModel userModel = UserModel(
          name: user?.displayName,
          email: user?.email,
          profilePictureUrl: user?.photoURL);
      return FirebaseAuthResponse(Status.success, user: userModel);
    } on FirebaseAuthException catch (e) {
      return FirebaseAuthResponse(Status.failure,
          message: FirebaseAuthErrorHandler.getAuthErrorMessage(e));
    } catch (e) {
      return FirebaseAuthResponse(Status.failure, message: e.toString());
    }
  }

  @override
  Future<FirebaseAuthResponse> connectWithGoogle() async {
    User? user;
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser != null) {
        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: gAuth.accessToken, idToken: gAuth.idToken);
        user = (await _firebaseAuth.signInWithCredential(credential)).user;
        UserModel userModel = UserModel(
            name: user?.displayName,
            email: user?.email,
            profilePictureUrl: user?.photoURL,
            isSignedInWithGoogle: true);
        return FirebaseAuthResponse(Status.success, user: userModel);
      }
      throw Exception();
    } on FirebaseAuthException catch (e) {
      return FirebaseAuthResponse(Status.failure,
          message: FirebaseAuthErrorHandler.getAuthErrorMessage(e));
    } catch (e) {
      return FirebaseAuthResponse(Status.failure, message: e.toString());
    }
  }

  @override
  Future<FirebaseBasicResponse> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return FirebaseBasicResponse(
          Status.failure, FirebaseAuthErrorHandler.getAuthErrorMessage(e));
    } catch (e) {
      return FirebaseBasicResponse(Status.failure, e.toString());
    }
    return const FirebaseBasicResponse(
        Status.success, "Debug: sign-out success response");
  }

  @override
  Future<FirebaseAuthResponse> signUp(SignUpRequest request) async {
    User? user;
    try {
      user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: request.emailAddress,
        password: request.password,
      ))
          .user;
      await user?.updateDisplayName(request.fullName);
      UserModel userModel = UserModel(
        name: request.fullName,
        email: user?.email,
        profilePictureUrl: user?.photoURL,
      );
      return FirebaseAuthResponse(Status.success, user: userModel);
    } on FirebaseAuthException catch (e) {
      return FirebaseAuthResponse(Status.failure,
          message: FirebaseAuthErrorHandler.getAuthErrorMessage(e));
    } catch (e) {
      return FirebaseAuthResponse(Status.failure, message: e.toString());
    }
  }

  @override
  Future<FirebaseAuthResponse> isSignedIn() async {
    User? user;
    user = _firebaseAuth.currentUser;
    final response =
        await _firebaseFirestore.collection('users').doc(user?.uid).get();
    EditProfileRequest? data;
    if (response.data() != null) {
      data = EditProfileRequest.fromMap(response.data()!);
    }
    UserModel userModel = UserModel(
      name: user?.displayName,
      email: user?.email,
      profilePictureUrl: user?.photoURL,
      gender: data?.genderId,
      birthDate: data?.dateOfBirth,
      isSignedInWithGoogle: user?.providerData[0].providerId == 'google.com',
    );
    return FirebaseAuthResponse(
      Status.success,
      user: userModel,
    );
  }

  @override
  Future<FirebaseBasicResponse> changePassword(
      ChangePasswordRequest input) async {
    try {
      final user = _firebaseAuth.currentUser;
      final cred = EmailAuthProvider.credential(
          email: user!.email!, password: input.oldPassword);

      await user.reauthenticateWithCredential(cred);
      user.updatePassword(input.newPassword);
      return const FirebaseBasicResponse(
          Status.success, "Debug: change password success response");
    } on FirebaseAuthException catch (e) {
      return FirebaseBasicResponse(Status.failure,
          FirebaseAuthErrorHandler.getChangePasswordErrorMessage(e));
    } catch (e) {
      return FirebaseBasicResponse(Status.failure, e.toString());
    }
  }

  @override
  Future<FirebaseAuthResponse> editProfile(EditProfileRequest request) async {
    try {
      final User? user = _firebaseAuth.currentUser;
      await user?.updateDisplayName(request.fullName);
      await _firebaseFirestore
          .collection('users')
          .doc(user?.uid)
          .set(request.toMap());

      UserModel userModel = UserModel(
        name: request.fullName,
        email: user?.email,
        profilePictureUrl: user?.photoURL,
        gender: request.genderId,
        birthDate: request.dateOfBirth,
        isSignedInWithGoogle: user?.providerData[0].providerId == 'google.com',
      );
      return FirebaseAuthResponse(
        Status.success,
        user: userModel,
      );
    } on FirebaseAuthException catch (e) {
      return FirebaseAuthResponse(Status.failure,
          message: FirebaseAuthErrorHandler.getAuthErrorMessage(e));
    } catch (e) {
      return FirebaseAuthResponse(Status.failure, message: e.toString());
    }
  }
}
