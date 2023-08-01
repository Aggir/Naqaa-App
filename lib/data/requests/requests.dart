import 'base_request.dart';

class SignInRequest implements BaseRequest {
  final String emailAddress;
  final String password;
  const SignInRequest({
    required this.emailAddress,
    required this.password,
  });
}

class SignUpRequest implements BaseRequest {
  final String fullName;
  final String emailAddress;
  final String password;
  const SignUpRequest({
    required this.fullName,
    required this.emailAddress,
    required this.password,
  });
}

class SendResetPasswordInstructionsRequest implements BaseRequest {
  final String emailAddress;
  const SendResetPasswordInstructionsRequest({
    required this.emailAddress,
  });
}
