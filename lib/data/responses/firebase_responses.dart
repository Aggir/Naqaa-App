import 'package:naqaa/app/enum.dart';

import '../models/user.dart';
import 'responses.dart';

class FirebaseAuthResponse extends AuthResponse {
  FirebaseAuthResponse(
    Status status, {
    String? message,
    UserModel? user,
  }) : super(status, message: message, user: user);
}

class FirebaseResetPasswordInstructionsResponse
    extends ResetPasswordInstructionsResponse {
  FirebaseResetPasswordInstructionsResponse(Status status, String message)
      : super(status, message);
}
