// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:herbal_tea_assistant/widgets/list_tiles.dart';
import 'package:path_provider/path_provider.dart';
import 'tea_data.dart';
import 'recipe_detail_page.dart';

class RecipesPage extends StatefulWidget {
  final List<String> selectedHerbs;

  const RecipesPage({required this.selectedHerbs});
  @override
  // ignore: no_logic_in_create_state
  _RecipesPageState createState() => _RecipesPageState(selectedHerbs: selectedHerbs);
}

class _RecipesPageState extends State<RecipesPage> {
    final List<String> selectedHerbs;
    
  _RecipesPageState({required this.selectedHerbs});

  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<MapEntry<String, Map<String, dynamic>>> _getFilteredRecipes() {
    return herbalTeaRecipes.entries
        .where((entry) {
          final recipeIngredients = entry.value['Ingredients'] as List<String>;
          final matchesSearchQuery = entry.key.toLowerCase().contains(_searchQuery) ||
              recipeIngredients.any((ingredient) => ingredient.toLowerCase().contains(_searchQuery));
          final matchesSelectedHerbs = widget.selectedHerbs.isEmpty ||
              widget.selectedHerbs.any((herb) => recipeIngredients.contains(herb));

          return matchesSearchQuery && matchesSelectedHerbs;
        })
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, Map<String, dynamic>>> filteredRecipes = _getFilteredRecipes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Recipes'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Browse recipes'),
                    content: const Text(
                        'Browse a wide range of custom herbal teas, sorted by ingredients. Search for teas matching your preferences at the top. Save your favorites for later using the save button. You can view saved recipes in \'Saved Notes\'.'),
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
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: buildDrawer(context),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Ingredients',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipeEntry = filteredRecipes[index];
                final recipeTitle = recipeEntry.key;
                final ingredients = recipeEntry.value['Ingredients'];

                return ListTile(
                  title: Text(recipeTitle),
                  subtitle: Text(ingredients.join(', ')),
                  trailing: IconButton(
                    icon: const Icon(Icons.save_alt),
                    onPressed: () {
                      final recipeText = '$recipeTitle\nIngredients: ${ingredients.join(', ')}';
                      _saveNotes(recipeText);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Recipe saved')),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailPage(
                          recipeTitle: recipeTitle,
                          recipeData: recipeEntry.value,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _saveNotes(String message) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/recipes.txt');
      final copiedRecipe = '===NoteDelimiter===$message';
      await file.writeAsString(copiedRecipe, mode: FileMode.append);
    } catch (e) {
      // Handle errors
    }
  }
}
