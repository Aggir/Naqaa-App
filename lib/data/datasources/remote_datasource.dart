import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthResponse> signIn(SignInRequest request);

  Future<SignOutResponse> signOut();

  Future<AuthResponse> signUp(SignUpRequest request);

  Future<AuthResponse> connectWithGoogle();

  Future<AuthResponse> isSignedIn();

  Future<ResetPasswordInstructionsResponse> sendResetPasswordInstructions(
      SendResetPasswordInstructionsRequest request);
}
