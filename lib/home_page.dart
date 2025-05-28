// ignore_for_file: use_build_context_synchronously

import 'package:herbal_tea_assistant/widgets/list_tiles.dart';
import 'package:provider/provider.dart';
import 'disclaimer_provider.dart';
import 'package:flutter/material.dart';
import 'package:herbal_tea_assistant/secrets.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    super.initState();
    Secrets.initializeApiKey();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<DisclaimerProvider>(
      builder: (context, disclaimerProvider, child) {
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
        backgroundColor: Colors.grey[900], 
        iconTheme: const IconThemeData(color: Colors.white), 
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
                            color: Color.fromRGBO(239, 108, 0, 1)
                            ),
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
                            color: Color.fromRGBO(239, 108, 0, 1)
                            ),
                        ),
                      ),
                      Image.asset('lib/logo.png', width: 225, height: 225),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: const Text(
                          'You must accept the disclaimer to use the app.',
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
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
        child: buildDrawer(context),
        ): buildDisclaimerDrawer(context),
      );
      },
    );
  }
}
