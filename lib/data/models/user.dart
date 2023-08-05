import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? name;
  final String? profilePictureUrl;
  final String? email;
  final int? birthDate;
  final String? gender;

  const UserModel({
    this.name,
    this.profilePictureUrl,
    this.email,
    this.birthDate,
    this.gender,
  });

  UserModel copyWith({
    String? name,
    String? profilePictureUrl,
    String? email,
    int? birthDate,
    String? gender,
  }) {
    return UserModel(
      name: name ?? this.name,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      profilePictureUrl,
      email,
      birthDate,
      gender,
    ];
  }

  @override
  String toString() {
    return 'UserModel(name: $name, profilePictureUrl: $profilePictureUrl, email: $email, birthDate: $birthDate, gender: $gender)';
  }
}
