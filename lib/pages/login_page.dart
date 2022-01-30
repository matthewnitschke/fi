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
  var _isCheckingAuthState = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _errorText;

  @override
  void initState() {
    super.initState();

    FiClient.isAuthenticated().then((isAuthed) {
      if (isAuthed) {
        _navigateToMainPage();
      } else {
        setState(() {
          _isCheckingAuthState = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        appBar: AppBar(title: const Text('Fi')),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: _isCheckingAuthState 
            ? const Center(child: CircularProgressIndicator())
            : Column(
              children: [
                const Text('Login', style: TextStyle(fontSize: 25)),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                if (_errorText != null) Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(_errorText!, style: const TextStyle(color: Colors.red),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: OutlinedButton(
                    onPressed: _authenticate,
                    child: const Text('Submit')
                  ),
                )
              ],
            ),
        )
    );
  }

  Future<void> _authenticate() async {
    try {
      await FiClient.authenticate(_emailController.text, _passwordController.text);
      _navigateToMainPage();
    } on InternalServerException catch(e) {
      setState(() => _errorText = e.message);
    } catch(e) {
      setState(() => _errorText = 'Unknown Error');
    }
  }

  void _navigateToMainPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainPage()));
  }
}
