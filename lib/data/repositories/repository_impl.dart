import 'package:dartz/dartz.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/data/datasources/remote_datasource.dart';
import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/domain/entities/user.dart';
import 'package:naqaa/domain/repositories/repository.dart';
import 'package:naqaa/data/mappers/user_mapper.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  const RepositoryImpl(this._remoteDataSource);

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

  @override
  Future<Either<Failure, void>> changePassword(
      ChangePasswordRequest input) async {
    final response = await _remoteDataSource.changePassword(input);
    if (response.status.isFailure) {
      return Left(Failure(0, response.message));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> editProfile(
      EditProfileRequest input) async {
    final response = await _remoteDataSource.editProfile(input);
    if (response.status.isFailure) {
      return Left(Failure(0, response.message!));
    } else {
      return Right(response.user!.toDomain());
    }
  }

  @override
  Future<Either<Failure, void>> addDevice(AddDeviceRequest input) async {
    final response = await _remoteDataSource.addDevice(input);
    if (response.status.isFailure) {
      return Left(Failure(0, response.message));
    } else {
      return const Right(null);
    }
  }
}
