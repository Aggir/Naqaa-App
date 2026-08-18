import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/domain/repositories/repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

class ChangePasswordUsecase
    implements BaseUsecase<ChangePasswordUsecaseInput, void> {
  final Repository _repository;
  const ChangePasswordUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(
      ChangePasswordUsecaseInput input) async {
    return await _repository.changePassword(ChangePasswordRequest(
        oldPassword: input.oldPassword, newPassword: input.newPassword));
  }
}

class ChangePasswordUsecaseInput {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordUsecaseInput({
    required this.oldPassword,
    required this.newPassword,
  });
}
