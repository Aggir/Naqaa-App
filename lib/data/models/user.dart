import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? name;
  final String? profilePictureUrl;
  final String? email;
  final int? dateOfBirth;
  final String? genderId;
  final bool? isSignedInWithGoogle;
  final int? modificationDate;
  final int? creationDate;
  final bool? isNewUser;
  final List<dynamic>? tokens;

  const UserModel({
    this.name,
    this.profilePictureUrl,
    this.email,
    this.dateOfBirth,
    this.genderId,
    this.isSignedInWithGoogle,
    this.modificationDate,
    this.creationDate,
    this.isNewUser,
    this.tokens,
  });

  UserModel copyWith({
    String? name,
    String? profilePictureUrl,
    String? email,
    int? dateOfBirth,
    String? genderId,
    bool? isSignedInWithGoogle,
    int? modificationDate,
    int? creationDate,
    bool? isNewUser,
    List<dynamic>? tokens,
  }) {
    return UserModel(
        name: name ?? this.name,
        profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
        email: email ?? this.email,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        genderId: genderId ?? this.genderId,
        isSignedInWithGoogle: isSignedInWithGoogle ?? this.isSignedInWithGoogle,
        modificationDate: modificationDate ?? this.modificationDate,
        creationDate: creationDate ?? this.creationDate,
        isNewUser: isNewUser ?? this.isNewUser,
        tokens: tokens ?? this.tokens);
  }

  @override
  List<Object?> get props {
    return [
      name,
      profilePictureUrl,
      email,
      dateOfBirth,
      genderId,
      isSignedInWithGoogle,
      modificationDate,
      creationDate,
      isNewUser,
      tokens
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePictureUrl': profilePictureUrl,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'genderId': genderId,
      'isSignedInWithGoogle': isSignedInWithGoogle,
      'modificationDate': modificationDate,
      'creationDate': creationDate,
      'isNewUser': isNewUser,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic>? map) {
    return UserModel(
      name: map?['name'],
      profilePictureUrl: map?['profilePictureUrl'],
      email: map?['email'],
      dateOfBirth: map?['dateOfBirth']?.toInt(),
      genderId: map?['genderId'],
      isSignedInWithGoogle: map?['isSignedInWithGoogle'],
      modificationDate: map?['modificationDate']?.toInt(),
      creationDate: map?['creationDate']?.toInt(),
      isNewUser: map?['isNewUser'],
      tokens: map?['tokens'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
