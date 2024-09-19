// mood_tracker_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'recipe_detail_page.dart';
import 'tea_data.dart';
//TODO functionality of this page WORKS
//need to change UI of appbar for a few pages, etc.
//need to add a few more moods AND change the teas for each mood to make sure there is more. 
//add a RANDOM for discovery. 
class MoodTrackerPage extends StatefulWidget {
  @override
  _MoodTrackerPageState createState() => _MoodTrackerPageState();
}

class _MoodTrackerPageState extends State<MoodTrackerPage> {
  String _selectedMood = '';
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
      _selectedMood = mood;
      _prefs.setString('selectedMood', mood);
      _savedMood = mood;
    });
  }

  List<String> _teaRecommendations(String mood) {
    switch (mood) {
      case 'Happy':
        return ['Minty Refresh Tea', 'Soothing Chamomile Blend', 'Energizing Matcha Latte'];
      case 'Sad':
        return ['Soothing Chamomile Blend', 'Calming Lavender Earl Grey'];
      case 'Stressed':
        return ['Minty Refresh Tea', 'Citrus Ginger Iced Tea', 'Creamy Vanilla Rooibos'];
      case 'Relaxed':
        return ['Soothing Chamomile Blend', 'Spiced Apple Cider Tea'];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracker'),
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'How are you feeling right now?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 10.0,
              children: [
                _moodButton('Happy', Icons.sentiment_very_satisfied),
                _moodButton('Sad', Icons.sentiment_dissatisfied),
                _moodButton('Stressed', Icons.sentiment_very_dissatisfied),
                _moodButton('Relaxed', Icons.sentiment_satisfied),
              ],
            ),
            SizedBox(height: 16),
            if (_savedMood != null) ...[
              Text(
                'Your saved mood: $_savedMood',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(height: 16),
              Text(
                'Recommended Teas:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 8),
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
                    color: Colors.deepOrange.shade100,
                    child: ListTile(
                      title: Text(
                        tea,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        herbalTeaRecipes[tea]!['Ingredients'].join(', '),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _moodButton(String mood, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () => _saveMood(mood),
      icon: Icon(icon, size: 24),
      label: Text(mood),
      style: ElevatedButton.styleFrom(
        // primary: Colors.deepOrange,
        // onPrimary: Colors.white,
        textStyle: TextStyle(fontSize: 16),
      ),
    );
  }
}
