import 'package:dartz/dartz.dart';
import 'package:naqaa/app/enums/status_enum.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/data/datasources/remote_datasource.dart';
import 'package:naqaa/data/mappers/device_details_mapper.dart';
import 'package:naqaa/data/mappers/device_mapper.dart';
import 'package:naqaa/data/mappers/notification_mapper.dart';
import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/domain/entities/device.dart';
import 'package:naqaa/domain/entities/device_details.dart';
import 'package:naqaa/domain/entities/notification.dart';
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
      return Left(Failure(0, response.message!));
    } else {
      return Right(response.message!);
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
      return Left(Failure(0, response.message!));
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
      return Left(Failure(0, response.message!));
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
      return Left(Failure(0, response.message!));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, Stream<List<DeviceEntity>>>> getDevices() async {
    final response = await _remoteDataSource.getDevices();
    if (response.status.isFailure) {
      return Left(Failure(0, response.message!));
    } else {
      return Right(response.devicesStream
              ?.map((event) => event.map((e) => e.toDomain()).toList()) ??
          const Stream.empty());
    }
  }

  @override
  Future<Either<Failure, void>> editDeviceName(
      EditDeviceNameRequest request) async {
    final response = await _remoteDataSource.editDeviceName(request);
    if (response.status.isFailure) {
      return Left(Failure(0, response.message!));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, Stream<DeviceDetailsEntity>>> getDeviceDetails(
      String id) async {
    final response = await _remoteDataSource.getDeviceDetails(id);
    if (response.status.isFailure) {
      return Left(Failure(0, response.message!));
    } else {
      return Right(
          response.deviceDetailsStream?.map((event) => event.toDomain()) ??
              const Stream.empty());
    }
  }

  @override
  Future<Either<Failure, void>> deleteDevice(String id) async {
    final response = await _remoteDataSource.deleteDevice(id);
    if (response.status.isFailure) {
      return Left(Failure(0, response.message!));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, Stream<List<NotificationEntity>>>>
      getUserNotifications() async {
    final response = await _remoteDataSource.getNotifications();
    if (response.status.isFailure) {
      return Left(Failure(0, response.message!));
    } else {
      return Right(response.notificationsStream
              ?.map((event) => event.map((e) => e.toDomain()).toList()) ??
          const Stream.empty());
    }
  }

  @override
  Future<Either<Failure, void>> seenNotifications() async {
    final response = await _remoteDataSource.seenNotifications();
    if (response.status.isFailure) {
      return Left(Failure(0, response.message!));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> readNotification(String notificationId) async {
    final response = await _remoteDataSource.readNotification(notificationId);
    if (response.status.isFailure) {
      return Left(Failure(0, response.message!));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> sendEmailVerification(String email) async {
    final response = await _remoteDataSource.sendEmailVerification(email);
    if (response.status.isFailure) {
      return Left(Failure(0, response.message!));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, bool>> checkEmailVerification(String email) async {
    final response = await _remoteDataSource.checkEmailVerification(email);
    if (response.status.isFailure) {
      return Left(Failure(0, response.message!));
    } else {
      return Right(response.isEmailVerified ?? false);
    }
  }
}
