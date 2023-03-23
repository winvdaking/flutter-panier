import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:panier/class/user.dart';
import 'package:panier/providers/userprovider.dart';

class LogoutForm extends StatefulWidget {
  const LogoutForm({super.key});

  @override
  State<LogoutForm> createState() => _LogoutFormState();
}

class _LogoutFormState extends State<LogoutForm> {
  UserProvider user = UserProvider();
  _LogoutFormState() {
    _logout(user.currentUser);
  }

  void _logout(User? user) async {
    try {
      await http.post(
        Uri.parse('https://fruits.shrp.dev/auth/logout'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "email": user!.email,
          "password": user.password,
        }),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Déconnexion"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            icon: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
      body: const Center(
        child: Text("Vous êtes maintenant déconnecté !"),
      ),
    );
  }
}
