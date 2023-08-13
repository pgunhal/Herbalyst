import 'package:chatgpt_client/home_page.dart';
import 'package:chatgpt_client/secrets.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  TextEditingController _apiKeyController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load user profile from the local file
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    try {
      final file = File(await _getFilePath());
      if (file.existsSync()) {
        final profileData = await file.readAsLines();
        _apiKeyController.text = profileData[0];
        _nameController.text = profileData[1];
        _emailController.text = profileData[2];
      }
    } catch (e) {
      // Handle any errors
    }
  }

void _saveUserProfile(BuildContext context) async {
  final file = File(await _getFilePath());
  final keyFile = File(await _getApiPath());
  final profileData = [
    _apiKeyController.text,
    _nameController.text,
    _emailController.text,
  ];

  try {
    await file.writeAsString(profileData.join('\n'));
    await keyFile.writeAsString(profileData[0]);
    Secrets.apiKey = profileData[0];

    // Reload the app by popping the current page and pushing it again
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  } catch (e) {
    // Handle any errors
  }
}


  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/profile.txt';
  }

    Future<String> _getApiPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/keyFinal.txt';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
                        TextField(
              controller: _apiKeyController,
              decoration: InputDecoration(labelText: 'API Key'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
  onPressed: () {
    _saveUserProfile(context); // Pass the context
  },
  child: Text('Save'),
),

          ],
        ),
      ),
    );
  }
}
