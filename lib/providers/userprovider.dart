import 'package:flutter/material.dart';
import 'package:panier/class/user.dart';
import 'package:jwt_decode/jwt_decode.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get currentUser => _user;

  void setCurrentUser(data, email, password) {
    var response = Jwt.parseJwt(data['access_token']);

    _user = User(
      id: response['id'],
      email: email,
      password: password,
      expires: data['expires'],
      accessToken: data['access_token'],
      refreshToken: data['refresh_token'],
      role: response['role'],
    );

    print(_user);

    notifyListeners();
  }

  bool isValid() {
    return _user?.accessToken != null ? true : false;
  }

  String? getAccessToken() => _user?.accessToken;
}
