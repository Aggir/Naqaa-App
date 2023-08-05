import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? name;
  final String? profilePictureUrl;
  final String? email;
  final int? birthDate;
  final String? gender;
  final bool? isSignedInWithGoogle;

  const UserModel({
    this.name,
    this.profilePictureUrl,
    this.email,
    this.birthDate,
    this.gender,
    this.isSignedInWithGoogle,
  });

  UserModel copyWith({
    String? name,
    String? profilePictureUrl,
    String? email,
    int? birthDate,
    String? gender,
    bool? isSignedInWithGoogle,
  }) {
    return UserModel(
      name: name ?? this.name,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      isSignedInWithGoogle: isSignedInWithGoogle ?? this.isSignedInWithGoogle,
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
      isSignedInWithGoogle,
    ];
  }
}
