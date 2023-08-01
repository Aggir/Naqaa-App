import 'package:naqaa/app/enum.dart';

import 'responses.dart';

class FirebaseSignInResponse extends SignInResponse {
  FirebaseSignInResponse(Status status, String message)
      : super(status, message);
}

class FirebaseSignUpResponse extends SignUpResponse {
  FirebaseSignUpResponse(Status status, String message)
      : super(status, message);
}

class FirebaseResetPasswordInstructionsResponse
    extends ResetPasswordInstructionsResponse {
  FirebaseResetPasswordInstructionsResponse(Status status, String message)
      : super(status, message);
}
