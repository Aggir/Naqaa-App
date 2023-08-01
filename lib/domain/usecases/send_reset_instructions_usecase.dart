import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/domain/repositories/auth_repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

class SendResetInstructionsUsecase implements BaseUsecase<String, String> {
  final AuthRepository _repository;
  const SendResetInstructionsUsecase(this._repository);
  @override
  Future<Either<Failure, String>> execute(String emailAddress) async {
    return _repository.sendResetPasswordInstructions(
        SendResetPasswordInstructionsRequest(emailAddress: emailAddress));
  }
}
