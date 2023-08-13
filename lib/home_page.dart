import 'dart:io';
import 'package:chatgpt_client/ingredients_page.dart';
import 'package:chatgpt_client/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:chatgpt_client/saved_chat_page.dart'; // Import the SavedChatPage
import 'package:chatgpt_client/secrets.dart';
import 'package:path_provider/path_provider.dart'; // Import the Secrets class

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _apiKeyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Secrets.initializeApiKey();
    // _loadApiKey(); // Call _loadApiKey to check and prompt if needed
  }

Future<void> _promptApiKey() async {
  final enteredApiKey = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Enter API Key'),
        content: TextField(
          controller: _apiKeyController,
          decoration: const InputDecoration(
            hintText: 'Enter your API key',
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _apiKeyController.text);
            },
            child: const Text('Submit'),
          ),
        ],
      );
    },
  );
  // Update the Secrets class
  if (enteredApiKey != null) {
    Secrets.apiKey = enteredApiKey;
    final directory = await getApplicationDocumentsDirectory();
    final keyFile = File('${directory.path}/keyFinal.txt');
    await keyFile.writeAsString(enteredApiKey);

    // Reload the app to hide the "Enter API Key" button
    // Use the key that you used when creating the MaterialApp widget
    final key = UniqueKey();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(key: key),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Herbal Tea Assistant',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[900], // black/gray as the app's primary color
      ),
      backgroundColor: Colors.grey[200], // Grey as the main background color
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
                         Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Unlock the power of herbal tea',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Color.fromRGBO(239, 108, 0, 1)),
              ),
            ),
            Image.asset('lib/logo.png', width: 225, height: 225),
            Container(
              padding: const EdgeInsets.all(15),
              child: Text(
                'This handy app is your companion on your journey to exploring the world of herbal teas. Whether you\'re a seasoned tea enthusiast or just starting, our app is designed to provide you with valuable information, personalized recommendations, and a platform to save your greatest recipes.',
                style: TextStyle(fontSize: 16, color: Colors.grey[900]),
              ),
            ),

            Container(
  padding: const EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Getting Started',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[900]),
      ),
     
      SizedBox(height: 4), // Add some spacing between title and list
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('1. Enter your OpenAI API key below.'),
          Text('2. Use \'Chat\' to converse with an AI tea-making assistant.'),
          Text('3. Save recipes using the copy button in the chat.'),
          Text('4. You can access your recipes or add new ones in the \'Saved Chat\' section'),
          Text('5. Use \'Browse Recipes\' to select or find herbs, and access available recipes using them.'),
        ],
      ),
    ],
  ),
),
  if (Secrets.apiKey == Secrets.defApiKey)
    Container(
      padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () => _promptApiKey(),
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 33, 33, 33), // Black button color
          ),
        child: const Text('Enter API Key'),
      ),
    ),
  ],
  ),
  ),
drawer: Drawer(
  child: Container(
    color: Colors.grey[300], // Set the background color
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(
          height: 125,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 33, 33, 33),
            ),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
         ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Profile'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfilePage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.chat),
          title: const Text('Chat'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/chat');
          },
        ),
        ListTile(
          leading: const Icon(Icons.restaurant_menu),
          title: const Text('Browse Recipes'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => IngredientsPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.save),
          title: const Text('Saved Chat'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => SavedChatPage()));
          },
        ),
        
      ],
    ),
  ),
),


    );
  }
}

