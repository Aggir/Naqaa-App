import 'package:dartz/dartz.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/data/datasources/remote_datasource.dart';
import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/domain/entites/user.dart';
import 'package:naqaa/domain/repositories/auth_repository.dart';
import 'package:naqaa/data/mappers/user_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource _remoteDataSource;
  const AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, String>> sendResetPasswordInstructions(
      SendResetPasswordInstructionsRequest input) async {
    final response =
        await _remoteDataSource.sendResetPasswordInstructions(input);
    if (response.status.isFailure) {
      return Left(Failure(0, response.message));
    } else {
      return Right(response.message);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(SignInRequest input) async {
    final response = await _remoteDataSource.signIn(input);
    if (response.status.isFailure) {
      return Left(Failure(0, response.message!));
    } else {
      return Right(response.user!.toDomain());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    final response = await _remoteDataSource.signOut();
    if (response.status.isFailure) {
      return Left(Failure(0, response.message));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(SignUpRequest input) async {
    final response = await _remoteDataSource.signUp(input);
    if (response.status.isFailure) {
      return Left(Failure(0, response.message!));
    } else {
      return Right(response.user!.toDomain());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> connectWithGoogle() async {
    final response = await _remoteDataSource.connectWithGoogle();
    if (response.status.isFailure) {
      return Left(Failure(0, response.message!));
    } else {
      return Right(response.user!.toDomain());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> isSignedIn() async {
    final response = await _remoteDataSource.isSignedIn();
    if (response.status.isFailure) {
      return Left(Failure(0, response.message!));
    } else {
      return Right(response.user!.toDomain());
    }
  }
}
