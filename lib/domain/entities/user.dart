import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String genderId;
  final DateTime? dateOfBirth;
  final String email;
  final String profilePictureUrl;
  final bool isSignedInWithGoogle;
  final DateTime? modificationDate;
  final DateTime? creationDate;
  const UserEntity({
    required this.name,
    required this.genderId,
    this.dateOfBirth,
    required this.email,
    required this.profilePictureUrl,
    required this.isSignedInWithGoogle,
    this.modificationDate,
    this.creationDate,
  });

  @override
  List<Object?> get props {
    return [
      name,
      genderId,
      dateOfBirth,
      email,
      profilePictureUrl,
      isSignedInWithGoogle,
      modificationDate,
      creationDate,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'genderId': genderId,
      'dateOfBirth': dateOfBirth?.millisecondsSinceEpoch,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'isSignedInWithGoogle': isSignedInWithGoogle,
      'modificationDate': modificationDate?.millisecondsSinceEpoch,
      'creationDate': creationDate?.millisecondsSinceEpoch,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      name: map['name'] ?? '',
      genderId: map['genderId'] ?? '',
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'])
          : null,
      email: map['email'] ?? '',
      profilePictureUrl: map['profilePictureUrl'] ?? '',
      isSignedInWithGoogle: map['isSignedInWithGoogle'] ?? false,
      modificationDate: map['modificationDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['modificationDate'])
          : null,
      creationDate: map['creationDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['creationDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source));

  UserEntity copyWith({
    String? name,
    String? genderId,
    DateTime? dateOfBirth,
    String? email,
    String? profilePictureUrl,
    bool? isSignedInWithGoogle,
    DateTime? creationDate,
    DateTime? modificationDate,
  }) {
    return UserEntity(
      name: name ?? this.name,
      genderId: genderId ?? this.genderId,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      email: email ?? this.email,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      isSignedInWithGoogle: isSignedInWithGoogle ?? this.isSignedInWithGoogle,
      creationDate: creationDate ?? this.creationDate,
      modificationDate: modificationDate ?? this.modificationDate,
    );
  }

  @override
  String toString() {
    return 'UserEntity(name: $name, genderId: $genderId, dateOfBirth: $dateOfBirth, email: $email, profilePictureUrl: $profilePictureUrl, isSignedInWithGoogle: $isSignedInWithGoogle, modificationDate: $modificationDate, creationDate: $creationDate)';
  }
}
