import 'dart:convert';

class User {
  final String id;
  final String email;
  final String password;
  final String refreshToken;
  final String accessToken;
  final String role;
  final int expires;

  User(
      {required this.id,
      required this.role,
      required this.email,
      required this.password,
      required this.refreshToken,
      required this.accessToken,
      required this.expires});

  @override
  String toString() {
    return "id: $id, email: $email, access_token: $accessToken";
  }
}
