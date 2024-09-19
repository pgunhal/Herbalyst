import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final String recipeTitle;
  final Map<String, dynamic> recipeData;

  RecipeDetailPage({required this.recipeTitle, required this.recipeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeTitle),
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ingredients',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 8),
            ...recipeData['Ingredients'].map<Widget>((ingredient) {
              return Text(
                ingredient,
                style: TextStyle(fontSize: 18, color: Colors.black),
              );
            }).toList(),
            SizedBox(height: 16),
            Text(
              'Health Benefits',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              recipeData['Health Benefits'],
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 16),
            Text(
              'Recipe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 8),
            ...recipeData['Recipe'].map<Widget>((step) {
              return Text(
                step,
                style: TextStyle(fontSize: 18, color: Colors.black),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
