import 'package:naqaa/app/constants.dart';
import 'package:naqaa/data/models/user.dart';
import 'package:naqaa/domain/entites/user.dart';

extension UserModelExtension on UserModel {
  UserEntity toDomain() {
    return UserEntity(
        name: name ?? Constants.empty,
        gender: gender ?? Constants.empty,
        dateOfBirth: birthDate != null
            ? DateTime.fromMillisecondsSinceEpoch(birthDate!)
            : null,
        email: email ?? Constants.empty,
        profilePictureUrl: profilePictureUrl ?? Constants.empty);
  }
}
