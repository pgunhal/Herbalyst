// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final String recipeTitle;
  final Map<String, dynamic> recipeData;

  const RecipeDetailPage({required this.recipeTitle, required this.recipeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeTitle),
          foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ingredients',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            ...recipeData['Ingredients'].map<Widget>((ingredient) {
              return Text(
                ingredient,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              );
            }).toList(),
            const SizedBox(height: 16),
            const Text(
              'Health Benefits',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              recipeData['Health Benefits'],
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 16),
            const Text(
              'Recipe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            ...recipeData['Recipe'].map<Widget>((step) {
              return Text(
                step,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
