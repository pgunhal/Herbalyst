import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:herbal_tea_assistant/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  bool _isRegistering = false; // Flag to toggle between login and registration

  Future<void> _loginOrRegister() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (_isRegistering) {
      // Save new credentials
      await _storage.write(key: 'username', value: username);
      await _storage.write(key: 'password', value: password);

      // Set login status
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(isLoggedIn: false)));
    } else {
      // Check credentials for login
      String? storedUsername = await _storage.read(key: 'username');
      String? storedPassword = await _storage.read(key: 'password');

      if (username == storedUsername && password == storedPassword) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(isLoggedIn: true,)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid credentials')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isRegistering ? 'Register' : 'Login'),
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loginOrRegister,
              child: Text(_isRegistering ? 'Create Account' : 'Login'),
            ),
            TextButton(
              onPressed: () => setState(() => _isRegistering = !_isRegistering),
              child: Text(_isRegistering ? 'Already have an account? Login' : 'Create a new account'),
            ),
          ],
        ),
      ),
    );
  }
}
