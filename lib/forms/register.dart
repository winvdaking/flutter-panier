import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _signUp(email, password, role) async {
    try {
      var response = await http.post(
        Uri.parse('https://fruits.shrp.dev/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
          "role": role
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
                    var response = _signUp(
                        emailController.text,
                        passwordController.text,
                        "ca2c1507-d542-4f47-bb63-a9c44a536498");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data : $response')),
                    );
                  }
                },
                child: const Text("S'inscrire"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
