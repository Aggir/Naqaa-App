import 'package:naqaa/app/enum.dart';
import 'package:naqaa/data/models/user.dart';
import 'package:naqaa/data/responses/base_response.dart';

class AuthResponse implements BaseResponse {
  final Status status;
  final UserModel? user;
  final String? message;
  const AuthResponse(this.status, {this.user, this.message});
}

class BasicResponse implements BaseResponse {
  final Status status;
  final String message;
  const BasicResponse(this.status, this.message);
}
