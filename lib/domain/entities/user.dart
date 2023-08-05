import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String gender;
  final DateTime? dateOfBirth;
  final String email;
  final String profilePictureUrl;
  final bool isSignedInWithGoogle;
  const UserEntity({
    required this.name,
    required this.gender,
    this.dateOfBirth,
    required this.email,
    required this.profilePictureUrl,
    required this.isSignedInWithGoogle,
  });

  @override
  List<Object?> get props {
    return [
      name,
      gender,
      dateOfBirth,
      email,
      profilePictureUrl,
      isSignedInWithGoogle,
    ];
  }
}
