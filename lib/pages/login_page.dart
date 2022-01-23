import 'package:fi/client.dart';
import 'package:fi/pages/main_page.dart';
import 'package:fi/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        appBar: AppBar(title: const Text('Fi')),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Column(
            children: [
              const Text('Login', style: TextStyle(fontSize: 25)),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: OutlinedButton(
                  onPressed: () {
                    FiClient.authenticate(emailController.text, passwordController.text)
                      .then((_) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainPage()));
                      });
                  },
                  child: const Text('Submit')
                ),
              )
            ],
          ),
        )
    );
  }
}
