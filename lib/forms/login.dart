import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _signIn(email, password) async {
    try {
      var response = await http.post(
        Uri.parse('https://fruits.shrp.dev/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
        }),
      );

      print(jsonDecode(utf8.decode(response.bodyBytes)) as Map);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Inscription"),
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
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text("Créer un compte"),
              ),
            ),
            Row(children: [
              const Flexible(
                flex: 2,
                child: Text("Email :"),
              ),
              Flexible(
                flex: 1,
                child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le champ Email ne peut pas être vide.';
                      }
                      return null;
                    }),
              ),
            ]),
            Row(children: [
              const Flexible(
                flex: 2,
                child: Text("Mot de passe :"),
              ),
              Flexible(
                flex: 1,
                child: TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le champ Mot de passe ne peut pas être vide.';
                      }
                      return null;
                    }),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var response = _signIn(
                      emailController.text,
                      passwordController.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data : $response')),
                    );
                  }
                },
                child: const Text("Se connecter"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
