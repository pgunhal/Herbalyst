import 'package:flutter/material.dart';
import 'package:herbal_tea_assistant/article_list_page.dart';
import 'package:herbal_tea_assistant/disclaimer_page.dart';
import 'package:herbal_tea_assistant/home_page.dart';
import 'package:herbal_tea_assistant/recipes_page.dart';
import 'package:herbal_tea_assistant/saved_chat_page.dart';
import 'package:herbal_tea_assistant/saved_ingredients_page.dart';
import 'package:herbal_tea_assistant/support_page.dart';


Widget buildDrawer(BuildContext context) {
  return Container(
          color: Colors.grey[300], 
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
              buildListTiles(context),
            ],
          ),
        );
}


Widget buildDisclaimerDrawer(BuildContext context) {
  return Container(
          color: Colors.grey[300], 
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
              disclaimerTiles(context),              
            ],
          ),
        );
}


Widget buildListTiles(BuildContext context) {
  return Column(
    children: [
      ListTile(
      leading: const Icon(Icons.home),
      title: const Text('Home'),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
    ),
    ListTile(
      leading: const Icon(Icons.warning),
      title: const Text('Disclaimer'),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DisclaimerPage()),
        );
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
      leading: const Icon(Icons.mood),
      title: const Text('Mood Tracker'),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/moodTracker');
      },
    ),
    ListTile(
      leading: const Icon(Icons.article),
      title: const Text('Articles'),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArticlesListPage()),
        );
      },
    ),
    ListTile(
      leading: const Icon(Icons.restaurant_menu),
      title: const Text('Browse Recipes'),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipesPage(selectedHerbs: const []),
          ),
        );
      },
    ),
    ListTile(
      leading: const Icon(Icons.food_bank),
      title: const Text('Browse Ingredients'),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SavedIngredientsPage()),
        );
      },
    ),
    ListTile(
      leading: const Icon(Icons.save_alt),
      title: const Text('Saved Notes'),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SavedRecipesPage()),
        );
      },
    ),
    ListTile(
      leading: const Icon(Icons.person),
      title: const Text('Support'),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SupportPage()),
        );
      },
    ),
    ],
  );
}




Widget disclaimerTiles(BuildContext context) {
  return Column(
    children: [
      ListTile(
      leading: const Icon(Icons.home),
      title: const Text('Home'),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
    ),
    ListTile(
      leading: const Icon(Icons.warning),
      title: const Text('Disclaimer'),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DisclaimerPage()),
        );
      },
    ),
    ],
  );
}
