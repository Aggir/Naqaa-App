import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<SignInResponse> signIn(SignInRequest request);

  Future<SignOutResponse> signOut();

  Future<SignUpResponse> signUp(SignUpRequest request);

  Future<ResetPasswordInstructionsResponse> sendResetPasswordInstructions(
      SendResetPasswordInstructionsRequest request);
}
