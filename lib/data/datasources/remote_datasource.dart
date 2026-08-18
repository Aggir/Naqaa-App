import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthResponse> signIn(SignInRequest request);

  Future<BasicResponse> signOut();

  Future<AuthResponse> signUp(SignUpRequest request);

  Future<AuthResponse> connectWithGoogle();

  Future<AuthResponse> isSignedIn();

  Future<BasicResponse> changePassword(ChangePasswordRequest request);

  Future<BasicResponse> sendResetPasswordInstructions(
      SendResetPasswordInstructionsRequest request);

  Future<AuthResponse> editProfile(EditProfileRequest request);

  Future<BasicResponse> addDevice(AddDeviceRequest request);

  Future<BasicResponse> deleteDevice(String macAddress);

  Future<DevicesResponse> getDevices();

  Future<BasicResponse> editDeviceName(EditDeviceNameRequest request);

  Future<DeviceDetailsResponse> getDeviceDetails(String macAddress);

  Future<NotificationsResponse> getNotifications();

  Future<BasicResponse> seenNotifications();

  Future<BasicResponse> readNotification(notificationId);

  Future<BasicResponse> sendEmailVerification(email);

  Future<EmailVerificationResponse> checkEmailVerification(email);

  Future<StatisticsResponse> getStatistics(StatisticsRequest request);
}
