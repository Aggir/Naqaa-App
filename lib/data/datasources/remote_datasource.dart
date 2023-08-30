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

  // Future<BasicResponse> getNotifications();

  // Future<BasicResponse> readNotifications();

  // Future<BasicResponse> getNotificationsCount();
}
