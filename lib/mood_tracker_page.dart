// mood_tracker_page.dart
// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:herbal_tea_assistant/widgets/list_tiles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'recipe_detail_page.dart';
import 'tea_data.dart';

class MoodTrackerPage extends StatefulWidget {
  @override
  _MoodTrackerPageState createState() => _MoodTrackerPageState();
}

class _MoodTrackerPageState extends State<MoodTrackerPage> {
  String? _savedMood;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedMood = _prefs.getString('selectedMood');
    });
  }

  Future<void> _saveMood(String mood) async {
    setState(() {
      _prefs.setString('selectedMood', mood);
      _savedMood = mood;
    });
  }

  List<String> _teaRecommendations(String mood) {
    switch (mood) {
      case 'Happy':
        return ['Blueberry Merlot & Citrus Mint Julep Mocktail', 'Citrus Ginger Iced Tea', 'Energizing Matcha Latte', 'Raspberry Rose Mojito Mocktail', 'Mango Passionfruit Iced Tea'];
      case 'Sad':
        return ['Cherry Blossom Infused Chocolate Torte', 'Sparkling Citrus Negroni', 'Soothing Chamomile Blend', 'Calming Lavender Earl Grey', 'Hot Spiced Green Tea'];
      case 'Stressed':
        return ['Minty Refresh Tea', 'Citrus Ginger Iced Tea', 'Creamy Vanilla Rooibos', 'Iced Tea Sangria', 'Vanilla Pear Tea Compote Tartine'];
      case 'Relaxed':
        return ['Soothing Chamomile Blend', 'Spiced Apple Cider Tea', 'Dairy-Free Mint Chip Nice Cream', 'Raspberry Cream Martini', 'Pumpkin Spice Rooibos'];
      case 'Bored':
        var index = Random().nextInt(herbalTeaRecipes.length);
        return [herbalTeaRecipes.keys.elementAt(index)];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
          foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
          actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          ),
        ],
      ),
      drawer: Drawer(
        child: buildDrawer(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
            children: [
              const Text(
                'How are you feeling?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10.0,
                children: [
                  _moodButton('Happy', Icons.sentiment_very_satisfied),
                  _moodButton('Relaxed', Icons.sentiment_satisfied),
                  _moodButton('Bored', Icons.sentiment_neutral),
                  _moodButton('Sad', Icons.sentiment_dissatisfied),
                  _moodButton('Stressed', Icons.sentiment_very_dissatisfied),
                ],
              ),
              const SizedBox(height: 16),
              if (_savedMood != null) ...[
                // Text(
                //   'Your mood: $_savedMood',
                //   style: const TextStyle(fontSize: 18, color: Colors.black),
                // ),
                const SizedBox(height: 16),
                const Text(
                  'Recommended Teas:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 8),
                ..._teaRecommendations(_savedMood!).map((tea) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailPage(
                            recipeTitle: tea,
                            recipeData: herbalTeaRecipes[tea]!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 255, 204, 188),
                      child: ListTile(
                        title: Text(
                          tea,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          herbalTeaRecipes[tea]!['Ingredients'].join(', '),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _moodButton(String mood, IconData icon) {
  return ElevatedButton(
    onPressed: () => _saveMood(mood),
    style: ElevatedButton.styleFrom(
      shape: const CircleBorder(), 
      padding: const EdgeInsets.all(16),
    ),
    child: Icon(icon, size: 24),
  );
}



    void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mood Tracker'),
          content: const Text('Find personalized tea recommendations based on mood. Click on teas to open the recipe page. Feeling bored? Use the middle button for a random tea suggestion.'),
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
}


