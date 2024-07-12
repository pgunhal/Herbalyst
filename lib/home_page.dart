// ignore_for_file: use_build_context_synchronously

import 'package:herbal_tea_assistant/support_page.dart';
import 'package:herbal_tea_assistant/disclaimer_page.dart';
import 'package:provider/provider.dart';
import 'disclaimer_provider.dart';

import 'package:herbal_tea_assistant/recipes_page.dart';
import 'package:herbal_tea_assistant/saved_ingredients_page.dart';
import 'package:flutter/material.dart';
import 'package:herbal_tea_assistant/saved_chat_page.dart'; // Import the SavedChatPage
import 'package:herbal_tea_assistant/secrets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'article_list_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


Future<void> _checkAcceptedTOC() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool accepted = prefs.getBool('acceptedTOC') ?? false;
  if (!accepted) {
    Navigator.pushReplacementNamed(context, '/disclaimer');
  }
}

@override
void initState() {
  super.initState();
    Secrets.initializeApiKey();
  _checkAcceptedTOC();
}


//  void _checkDisclaimerStatus() async {
//     String? isAccepted = await _storage.read(key: 'disclaimerAccepted');
//     if (isAccepted != 'true') {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => DisclaimerPage()),
//       );
//     }
//   }



  @override
  Widget build(BuildContext context) {
     return Consumer<DisclaimerProvider>(
    builder: (context, disclaimerProvider, child) {
      if (!disclaimerProvider.isDisclaimerAccepted) {
        return DisclaimerPage();
      }
        return Scaffold(
         appBar: AppBar(
        title: const Text(
          'Herbalyst',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[900], // black/gray as the app's primary color
        iconTheme: const IconThemeData(color: Colors.white), // Set the icon color to white
      ),
          body: disclaimerProvider.isDisclaimerAccepted
              ? SingleChildScrollView(
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
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Color.fromRGBO(239, 108, 0, 1)),
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
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: const Text(
                          'Unlock the power of herbal tea',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Color.fromRGBO(239, 108, 0, 1)),
                        ),
                      ),
                      Image.asset('lib/logo.png', width: 225, height: 225),
                      const Text(
                        'You must accept the disclaimer to use the app.',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/disclaimer');
                        },
                        child: const Text('Read and Accept Disclaimer'),
                      ),
                    ],
                  ),
                ),
          drawer: disclaimerProvider.isDisclaimerAccepted
              ? Drawer(
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
                leading: const Icon(Icons.warning),
                title: const Text('Disclaimer'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DisclaimerPage()));
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
                title: const Text('Tea Recommendations'),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ArticlesListPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.restaurant_menu),
                title: const Text('Browse Recipes'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RecipesPage(selectedHerbs: [])));
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
                leading: const Icon(Icons.person),
                title: const Text('Support'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SupportPage()));
                },
              ),
              // ListTile(
              //   leading: Icon(widget.isLoggedIn ? Icons.logout : Icons.login),
              //   title: Text(widget.isLoggedIn ? 'Log out' : 'Login'),
              //   onTap: () {
              //     Navigator.pop(context); // Close the drawer
              //     if (widget.isLoggedIn) {
              //       _logout();
              //     } else {
              //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              //     }
              //   },
              // ),
            ],
          ),
        )
        ): null,
      );
      },
    );
  }
}
//       ),
//     );
//   }
// }
