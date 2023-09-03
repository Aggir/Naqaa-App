import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/enums/status_enum.dart';
import 'package:naqaa/data/datasources/remote_datasource.dart';
import 'package:naqaa/data/mappers/user_mapper.dart';
import 'package:naqaa/data/models/device_details_model.dart';
import 'package:naqaa/data/models/device_model.dart';
import 'package:naqaa/data/models/user.dart';
import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/data/responses/firebase_responses.dart';
import 'package:naqaa/data/responses/responses.dart';
import 'package:naqaa/domain/entities/user.dart';

import 'firebase_auth_error_handler.dart';
import 'firebase_constants.dart';

class FirebaseApi implements RemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseDatabase _firebaseDatabase;
  const FirebaseApi(
    this._firebaseAuth,
    this._firebaseFirestore,
    this._firebaseDatabase,
  );

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
      final response = await _firebaseFirestore
          .collection(FirebaseConstants.user)
          .doc(user?.uid)
          .get();
      UserModel userModel = UserModel.fromMap(response.data());
      if (userModel.isNewUser == true) {
        userModel = userModel.copyWith(isNewUser: false);
        await _firebaseFirestore
            .collection(FirebaseConstants.user)
            .doc(user?.uid)
            .set(userModel.toMap());
      }

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
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser != null) {
        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: gAuth.accessToken, idToken: gAuth.idToken);
        UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        User? user = userCredential.user;
        late UserModel userModel;
        if (userCredential.additionalUserInfo?.isNewUser ?? true) {
          userModel = UserModel(
            name: user?.displayName,
            email: user?.email,
            profilePictureUrl: user?.photoURL,
            isSignedInWithGoogle: true,
            creationDate: user?.metadata.creationTime?.millisecondsSinceEpoch,
            modificationDate:
                user?.metadata.creationTime?.millisecondsSinceEpoch,
            isNewUser: userCredential.additionalUserInfo?.isNewUser,
          );
          await _firebaseFirestore
              .collection(FirebaseConstants.user)
              .doc(user?.uid)
              .set(userModel.toMap());
        } else {
          final response = await _firebaseFirestore
              .collection(FirebaseConstants.user)
              .doc(user?.uid)
              .get();
          userModel = UserModel.fromMap(response.data());
          if (userModel.isNewUser !=
              userCredential.additionalUserInfo?.isNewUser) {
            userModel = userModel.copyWith(
              isNewUser: userCredential.additionalUserInfo?.isNewUser,
            );
            await _firebaseFirestore
                .collection(FirebaseConstants.user)
                .doc(user?.uid)
                .set(userModel.toMap());
          }
        }
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
    return FirebaseBasicResponse(
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
        creationDate: user?.metadata.creationTime?.millisecondsSinceEpoch,
        modificationDate: user?.metadata.creationTime?.millisecondsSinceEpoch,
        isNewUser: true,
        isSignedInWithGoogle: false,
      );
      await _firebaseFirestore
          .collection(FirebaseConstants.user)
          .doc(user?.uid)
          .set(userModel.toMap());
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
    final response = await _firebaseFirestore
        .collection(FirebaseConstants.user)
        .doc(user?.uid)
        .get();
    UserModel userModel = UserModel.fromMap(response.data());
    if (userModel.isNewUser == true) {
      userModel = userModel.copyWith(isNewUser: false);
      await _firebaseFirestore
          .collection(FirebaseConstants.user)
          .doc(user?.uid)
          .set(userModel.toMap());
    }

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
      return FirebaseBasicResponse(
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
      UserEntity updatedUser = request.newUser;
      if (request.pickedImage != null && user != null) {
        final Reference profilePictureReference = FirebaseStorage.instance
            .ref()
            .child(FirebaseConstants.profilePictures)
            .child(user.uid);
        await profilePictureReference.putFile(request.pickedImage!);
        String newProfilePictureURL =
            await profilePictureReference.getDownloadURL();
        updatedUser = updatedUser.copyWith(
          profilePictureUrl: newProfilePictureURL,
        );
      }
      updatedUser = updatedUser.copyWith(
        modificationDate: DateTime.now(),
      );

      await user?.updateDisplayName(updatedUser.name);
      await _firebaseFirestore
          .collection(FirebaseConstants.user)
          .doc(user?.uid)
          .set(updatedUser.toMap());
      return FirebaseAuthResponse(
        Status.success,
        user: updatedUser.fromDomain(),
      );
    } on FirebaseAuthException catch (e) {
      return FirebaseAuthResponse(Status.failure,
          message: FirebaseAuthErrorHandler.getAuthErrorMessage(e));
    } catch (e) {
      return FirebaseAuthResponse(Status.failure, message: e.toString());
    }
  }

  @override
  Future<BasicResponse> addDevice(AddDeviceRequest request) async {
    try {
      final User? user = _firebaseAuth.currentUser;

      await _firebaseFirestore
          .collection(FirebaseConstants.device)
          .doc(request.id)
          .set({
        FirebaseConstants.userId: user?.uid,
        ...request.toMap(),
      });

      return BasicResponse(Status.success, 'success');
    } on FirebaseAuthException catch (e) {
      return BasicResponse(
          Status.failure, FirebaseAuthErrorHandler.getAuthErrorMessage(e));
    } catch (e) {
      return BasicResponse(Status.failure, e.toString());
    }
  }

  @override
  Future<DevicesResponse> getDevices() async {
    try {
      final User? user = _firebaseAuth.currentUser;
      final Stream<QuerySnapshot<Map<String, dynamic>>> userDevicesStream =
          _firebaseFirestore
              .collection(FirebaseConstants.device)
              .where(FirebaseConstants.userId, isEqualTo: user?.uid)
              .snapshots();

      return DevicesResponse(
          status: Status.success,
          devicesStream: userDevicesStream.map((snapshot) =>
              (snapshot.docs.map((doc) => doc.data()))
                  .map((e) => DeviceModel.fromMap(e))
                  .toList()));
    } on FirebaseAuthException catch (e) {
      print(e);
      return DevicesResponse(
          status: Status.failure,
          message: FirebaseAuthErrorHandler.getAuthErrorMessage(e));
    } catch (e) {
      print(e);
      return DevicesResponse(status: Status.failure, message: e.toString());
    }
  }

  @override
  Future<BasicResponse> editDeviceName(EditDeviceNameRequest request) async {
    try {
      await _firebaseFirestore
          .collection(FirebaseConstants.device)
          .doc(request.id)
          .update(request.toMap());
      return BasicResponse(Status.success, 'success');
    } on FirebaseAuthException catch (e) {
      return BasicResponse(
          Status.failure, FirebaseAuthErrorHandler.getAuthErrorMessage(e));
    } catch (e) {
      return BasicResponse(Status.failure, e.toString());
    }
  }

  @override
  Future<DeviceDetailsResponse> getDeviceDetails(String id) async {
    try {
      final response = _firebaseDatabase.ref().child(id).ref.onValue;

      return DeviceDetailsResponse(
          status: Status.success,
          deviceDetailsStream: response.map((event) =>
              DeviceDetailsModel.fromMap(
                  event.snapshot.value as Map<Object?, Object?>?)));
    } on FirebaseAuthException catch (e) {
      print(e);
      return DeviceDetailsResponse(
        status: Status.failure,
        message: FirebaseAuthErrorHandler.getAuthErrorMessage(e),
      );
    } catch (e) {
      print(e);
      return DeviceDetailsResponse(
        status: Status.failure,
        message: e.toString(),
      );
    }
  }

  @override
  Future<BasicResponse> deleteDevice(String id) async {
    try {
      await _firebaseFirestore
          .collection(FirebaseConstants.device)
          .doc(id)
          .delete();

      return BasicResponse(Status.success, 'success');
    } on FirebaseAuthException catch (e) {
      return BasicResponse(
          Status.failure, FirebaseAuthErrorHandler.getAuthErrorMessage(e));
    } catch (e) {
      return BasicResponse(Status.failure, e.toString());
    }
  }
}
