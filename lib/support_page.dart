// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  void initState() {
    super.initState();
  }
  void _contactSupport() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please reach out to support@herbalyst.com with any inquiries or support queries.')));

    // if (_passwordController.text == _confirmPasswordController.text) {
    //   await _storage.write(key: 'username', value: _usernameController.text);
    //   await _storage.write(key: 'password', value: _passwordController.text);
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile Saved')));
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords do not match')));
    // }
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Support'),
          // backgroundColor: Colors.white,
          content: const Text('Find information for app support and reporting bugs here.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Support'),
          foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
             const Text('Having fun?', 
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25)
            ),
            const Text('If you are enjoying Herbalyst, please rate us on the App Store and leave a review!', 
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)
            ),
            const Text('Questions?', 
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25,)
            ),
            const Text('If you are unsure about how to use any features in the app, click on the information button in the top right corner of every screen.', 
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)
            ),
            const Text('Bugs?', 
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25)
            ),
            const Text('If you believe a feature is not working properly or find any other issues with the app, submit a bug report below and our support team will reach out with further steps.', 
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _contactSupport,
              child: const Text('Contact Support'),
            ),
          ],
        ),
      ),
    );
  }
}
