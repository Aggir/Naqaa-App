import 'package:naqaa/app/enum.dart';
import 'package:naqaa/data/responses/base_response.dart';

class SignInResponse implements BaseResponse {
  final Status status;
  final String message;
  const SignInResponse(this.status, this.message);
}

class SignUpResponse implements BaseResponse {
  final Status status;
  final String message;
  const SignUpResponse(this.status, this.message);
}

class ResetPasswordInstructionsResponse implements BaseResponse {
  final Status status;
  final String message;
  const ResetPasswordInstructionsResponse(this.status, this.message);
}
