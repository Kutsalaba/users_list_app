import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  const UserData({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.avatarUrl,
  });

  final int id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? avatarUrl;

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        avatarUrl,
      ];

  // @override
  // String toString() {
  //   return 'User: { '
  //       'id: $id, '
  //       'email: $email, '
  //       '}';
  // }

  UserData copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatarUrl,
  }) {
    return UserData(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatarUrl,
    };
  }

  factory UserData.fromJson(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] as int,
      email: map['email'] as String,
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
      avatarUrl: map['avatar'] != null ? map['avatar'] as String : null,
    );
  }
}
