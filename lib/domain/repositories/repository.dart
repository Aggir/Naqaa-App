import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/domain/entities/device.dart';
import 'package:naqaa/domain/entities/device_details.dart';
import 'package:naqaa/domain/entities/notification.dart';
import 'package:naqaa/domain/entities/statistic.dart';

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

  Future<Either<Failure, void>> addDevice(AddDeviceRequest input);

  Future<Either<Failure, void>> deleteDevice(String id);

  Future<Either<Failure, Stream<List<DeviceEntity>>>> getDevices();

  Future<Either<Failure, void>> editDeviceName(EditDeviceNameRequest request);

  Future<Either<Failure, Stream<DeviceDetailsEntity>>> getDeviceDetails(
      String macAddress);

  Future<Either<Failure, Stream<List<NotificationEntity>>>>
      getUserNotifications();

  Future<Either<Failure, void>> seenNotifications();

  Future<Either<Failure, void>> readNotification(String notificationId);

  Future<Either<Failure, void>> sendEmailVerification(String email);

  Future<Either<Failure, bool>> checkEmailVerification(String email);

  Future<Either<Failure, List<StatisticEntity>>> getStatistics(
      StatisticsRequest request);
}
