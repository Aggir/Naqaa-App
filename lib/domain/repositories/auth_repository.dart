import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/data/requests/requests.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> signIn(SignInRequest input);

  Future<Either<Failure, String>> signUp(SignUpRequest input);

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, String>> sendResetPasswordInstructions(
      SendResetPasswordInstructionsRequest input);
}
