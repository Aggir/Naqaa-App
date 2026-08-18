import 'package:naqaa/app/enums/status_enum.dart';

import '../models/user.dart';
import 'responses.dart';

class FirebaseAuthResponse extends AuthResponse {
  FirebaseAuthResponse(
    Status status, {
    String? message,
    UserModel? user,
  }) : super(status, message: message, user: user);
}

class FirebaseBasicResponse extends BasicResponse {
  FirebaseBasicResponse(Status status, String message) : super(status, message);
}
