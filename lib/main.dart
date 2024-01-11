import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatgpt_client/home_page.dart';
import 'package:chatgpt_client/login_page.dart';
import 'package:chatgpt_client/profile_page.dart';
import 'package:chatgpt_client/recipes_page.dart';
import 'package:chatgpt_client/ingredients_page.dart';
import 'package:chatgpt_client/saved_ingredients_page.dart';
import 'package:chatgpt_client/saved_chat_page.dart';
import 'package:chatgpt_client/article_list_page.dart';
import 'package:chatgpt_client/chat_page.dart';
import 'package:chatgpt_client/api/chat_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool loggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(HerbalTeaApp(isLoggedIn: loggedIn));
}

class HerbalTeaApp extends StatelessWidget {
  final bool isLoggedIn;

  HerbalTeaApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT Client',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        backgroundColor: Colors.grey[900],
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
      ),
      home: isLoggedIn ? HomePage(isLoggedIn: true,) : LoginPage(),
      routes: {
        '/home': (context) => HomePage(isLoggedIn: true,),
        '/login': (context) => LoginPage(),
        '/userProfile': (context) => UserProfilePage(),
        '/recipes': (context) => RecipesPage(selectedHerbs: []),
        '/ingredients': (context) => IngredientsPage(),
        '/savedIngredients': (context) => SavedIngredientsPage(),
        '/savedChat': (context) => SavedRecipesPage(),
        '/articlesList': (context) => ArticlesListPage(),
        '/chat': (context) => ChatPage(chatApi: ChatApi()),
      },
    );
  }
}
