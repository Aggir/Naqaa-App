import 'package:naqaa/app/constants.dart';
import 'package:naqaa/data/models/user.dart';
import 'package:naqaa/domain/entities/user.dart';

extension UserModelExtension on UserModel {
  UserEntity toDomain() {
    return UserEntity(
      name: name ?? Constants.empty,
      genderId: genderId ?? Constants.empty,
      dateOfBirth: dateOfBirth != null
          ? DateTime.fromMillisecondsSinceEpoch(dateOfBirth!)
          : null,
      email: email ?? Constants.empty,
      profilePictureUrl: profilePictureUrl ?? Constants.empty,
      isSignedInWithGoogle: isSignedInWithGoogle ?? false,
      creationDate: creationDate != null
          ? DateTime.fromMillisecondsSinceEpoch(creationDate!)
          : null,
      modificationDate: modificationDate != null
          ? DateTime.fromMillisecondsSinceEpoch(modificationDate!)
          : null,
      isNewUser: isNewUser ?? false,
    );
  }
}

extension UserEntityExtension on UserEntity {
  UserModel fromDomain() {
    return UserModel(
      name: name,
      genderId: genderId,
      dateOfBirth:
          dateOfBirth != null ? dateOfBirth!.millisecondsSinceEpoch : null,
      email: email,
      profilePictureUrl: profilePictureUrl,
      isSignedInWithGoogle: isSignedInWithGoogle,
      creationDate:
          creationDate != null ? creationDate!.millisecondsSinceEpoch : null,
      modificationDate: modificationDate != null
          ? modificationDate!.millisecondsSinceEpoch
          : null,
    );
  }
}
