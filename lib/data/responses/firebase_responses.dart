import 'package:naqaa/app/enum.dart';

import '../models/user.dart';
import 'responses.dart';

class FirebaseAuthResponse extends AuthResponse {
  const FirebaseAuthResponse(
    Status status, {
    String? message,
    UserModel? user,
  }) : super(status, message: message, user: user);
}

class FirebaseBasicResponse extends BasicResponse {
  const FirebaseBasicResponse(Status status, String message)
      : super(status, message);
}
