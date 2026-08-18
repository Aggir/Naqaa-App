import 'package:naqaa/app/enums/status_enum.dart';

abstract class BaseResponse {
  late Status status;
  String? message;
}
