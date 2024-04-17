import 'dart:io';
import 'package:herbal_tea_assistant/ingredients_page.dart';
import 'package:herbal_tea_assistant/profile_page.dart';
import 'package:herbal_tea_assistant/recipes_page.dart';
import 'package:herbal_tea_assistant/saved_ingredients_page.dart';
import 'package:flutter/material.dart';
import 'package:herbal_tea_assistant/saved_chat_page.dart'; // Import the SavedChatPage
import 'package:herbal_tea_assistant/secrets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'article.dart';
import 'article_display_page.dart';
import 'article_list_page.dart';
import 'login_page.dart'; // Import the Secrets class

class HomePage extends StatefulWidget {
 final bool isLoggedIn;
  const HomePage({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    Secrets.initializeApiKey();
    // _loadApiKey(); // Call _loadApiKey to check and prompt if needed
  }

    void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
  // child: Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     Text(
  //       'Getting Started',
  //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[900]),
  //     ),
     
      // SizedBox(height: 4), // Add some spacing between title and list
      // const Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text('- Use \'Chat\' to converse with an AI tea-making assistant.', style: TextStyle(fontSize: 14, color: Colors.black)),
      //     Text('- Save recipes using the copy button in the chat.', style: TextStyle(fontSize: 14, color: Colors.black)),
      //     Text('- You can access your recipes or add new ones in the \'Saved Chat\' section', style: TextStyle(fontSize: 14, color: Colors.black)),
      //     Text('- Use \'Browse Recipes\' to select or find herbs, and access available recipes using them.', style: TextStyle(fontSize: 14, color: Colors.black)),
      //   ],
      // ),
  //   ],
  // ),
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
          leading: const Icon(Icons.article),
          title: const Text('Articles'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => ArticlesListPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.restaurant_menu),
          title: const Text('Browse Recipes'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => RecipesPage(selectedHerbs: [],)));
          },
        ),
        ListTile(
          leading: const Icon(Icons.food_bank),
          title: const Text('Browse Ingredients'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => SavedIngredientsPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Saved Notes'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => SavedRecipesPage()));
          },
        ),
        ListTile(
              leading: Icon(widget.isLoggedIn ? Icons.logout : Icons.login),
              title: Text(widget.isLoggedIn ? 'Log out' : 'Login'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                if (widget.isLoggedIn) {
                  _logout();
                } else {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                }
              },
            ),




        
      ],
    ),
  ),
),


    );
  }
}

