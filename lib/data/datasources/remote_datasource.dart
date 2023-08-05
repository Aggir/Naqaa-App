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
}
