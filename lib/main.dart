// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:herbal_tea_assistant/disclaimer_provider.dart';
import 'package:herbal_tea_assistant/mood_tracker_page.dart';
import 'package:provider/provider.dart';
import 'package:herbal_tea_assistant/home_page.dart';
import 'package:herbal_tea_assistant/support_page.dart';
import 'package:herbal_tea_assistant/disclaimer_page.dart';

import 'package:herbal_tea_assistant/recipes_page.dart';
import 'package:herbal_tea_assistant/ingredients_page.dart';
import 'package:herbal_tea_assistant/saved_ingredients_page.dart';
import 'package:herbal_tea_assistant/saved_chat_page.dart';
import 'package:herbal_tea_assistant/article_list_page.dart';
import 'package:herbal_tea_assistant/chat_page.dart';
import 'package:herbal_tea_assistant/api/chat_api.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => DisclaimerProvider(),
      child: const Herbalyst(),
    ),
  );
}

class Herbalyst extends StatelessWidget {
  const Herbalyst();

  @override
  Widget build(BuildContext context) {
    return Consumer<DisclaimerProvider>(
      builder: (context, disclaimerProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false, // Disable debug banner
          title: 'Herbalyst',
          theme: ThemeData(
            textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange).copyWith(surface: Colors.grey[900]),
            scaffoldBackgroundColor: Colors.white,
            dialogBackgroundColor: Colors.grey[900],
            dialogTheme: const DialogTheme(titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
          ),
          initialRoute: disclaimerProvider.isDisclaimerAccepted ? '/home' : '/disclaimer',
          routes: {
            '/home': (context) => const HomePage(),
            '/support': (context) => SupportPage(),
            '/disclaimer': (context) => DisclaimerPage(),
            '/recipes': (context) => const RecipesPage(selectedHerbs: []),
            '/ingredients': (context) => IngredientsPage(),
            '/savedIngredients': (context) => SavedIngredientsPage(),
            '/savedChat': (context) => SavedRecipesPage(),
            '/articlesList': (context) => ArticlesListPage(),
            '/chat': (context) => ChatPage(chatApi: ChatApi()),
            '/moodTracker': (context) => const MoodTrackerPage(),
          },
        );
      },
    );
  }
}
