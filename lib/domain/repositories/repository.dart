import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/data/requests/requests.dart';

import '../entities/user.dart';

abstract class Repository {
  Future<Either<Failure, UserEntity>> signIn(SignInRequest input);

  Future<Either<Failure, UserEntity>> isSignedIn();

  Future<Either<Failure, UserEntity>> signUp(SignUpRequest input);

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, UserEntity>> connectWithGoogle();

  Future<Either<Failure, void>> changePassword(ChangePasswordRequest input);

  Future<Either<Failure, String>> sendResetPasswordInstructions(
      SendResetPasswordInstructionsRequest input);

  Future<Either<Failure, UserEntity>> editProfile(EditProfileRequest input);
}
