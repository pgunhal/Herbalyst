import 'package:flutter/material.dart';
import 'package:herbal_tea_assistant/disclaimer_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:herbal_tea_assistant/home_page.dart';
import 'package:herbal_tea_assistant/login_page.dart';
import 'package:herbal_tea_assistant/support_page.dart';
import 'package:herbal_tea_assistant/disclaimer_page.dart';

import 'package:herbal_tea_assistant/recipes_page.dart';
import 'package:herbal_tea_assistant/ingredients_page.dart';
import 'package:herbal_tea_assistant/saved_ingredients_page.dart';
import 'package:herbal_tea_assistant/saved_chat_page.dart';
import 'package:herbal_tea_assistant/article_list_page.dart';
import 'package:herbal_tea_assistant/chat_page.dart';
import 'package:herbal_tea_assistant/api/chat_api.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool loggedIn = prefs.getBool('isLoggedIn') ?? false;
//   runApp(HerbalTeaApp(isLoggedIn: loggedIn));
// }

// class HerbalTeaApp extends StatelessWidget {
//   final bool isLoggedIn;

//   HerbalTeaApp({required this.isLoggedIn});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false, // Disable debug banner
//       title: 'ChatGPT Client',
//       theme: ThemeData(
//         textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange).copyWith(surface: Colors.grey[900]),
//       ),
//       home: HomePage(),
//     initialRoute: '/',
//       routes: {
//         '/': (context) => HomePage(),
//         '/support': (context) => SupportPage(),
//         '/disclaimer': (context) => DisclaimerPage(),
//         '/recipes': (context) => RecipesPage(selectedHerbs: []),
//         '/ingredients': (context) => IngredientsPage(),
//         '/savedIngredients': (context) => SavedIngredientsPage(),
//         '/savedChat': (context) => SavedRecipesPage(),
//         '/articlesList': (context) => ArticlesListPage(),
//         '/chat': (context) => ChatPage(chatApi: ChatApi()),
//       },
//     );
//   }
// }


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool loggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(
    ChangeNotifierProvider(
      create: (context) => DisclaimerProvider(),
      child: HerbalTeaApp(isLoggedIn: loggedIn),
    ),
  );
}

class HerbalTeaApp extends StatelessWidget {
  final bool isLoggedIn;

  HerbalTeaApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner
      title: 'Herbalyst',
      theme: ThemeData(
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange).copyWith(surface: Colors.grey[900]),
        scaffoldBackgroundColor: Colors.white,
        dialogBackgroundColor: Colors.grey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/support': (context) => SupportPage(),
        '/disclaimer': (context) => DisclaimerPage(),
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