import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart'; // Import the library for clipboard manipulation


class RecipesPage extends StatefulWidget {
  final List<String> selectedHerbs;

  RecipesPage({required this.selectedHerbs});

  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
Map<String, List<String>> herbalTeaRecipes = {
  'Minty Refresh Tea': ['Mint', 'Lemon Balm'],
  'Soothing Chamomile Blend': ['Chamomile', 'Lavender'],
  'Citrus Zest Infusion': ['Lemon Peel', 'Orange Peel'],
  'Spiced Herbal Delight': ['Cinnamon', 'Cardamom', 'Clove'],
  'Floral Elegance Tea': ['Rose Petals', 'Lavender'],
  'Digestive Harmony Blend': ['Peppermint', 'Ginger', 'Lemon Balm'],
  'Energizing Nettle Fusion': ['Nettle', 'Mint'],
  'Sleepytime Blend': ['Chamomile', 'Lemon Balm', 'Valerian'],
  'Immune Boost Elixir': ['Echinacea', 'Ginger', 'Turmeric'],
  'Herbal Green Tea': ['Mint', 'Lemon Balm', 'Spearmint'],
  'Calming Lavender Chamomile': ['Chamomile', 'Lavender'],
  'Herbal Chai Tea': ['Cinnamon', 'Cardamom', 'Clove', 'Ginger'],
  'Spiced Citrus Herbal Tea': ['Cinnamon', 'Orange Peel', 'Lemon Peel'],
  'Relaxing Lavender Mint': ['Lavender', 'Peppermint'],
  'Herbal Wellness Tea': ['Echinacea', 'Nettle', 'Lemon Balm'],
  'Herb Garden Medley': ['Basil', 'Thyme', 'Rosemary', 'Oregano'],
  'Detoxifying Herbal Blend': ['Dandelion', 'Nettle', 'Burdock Root'],
  'Anti-Inflammatory Herbal Tea': ['Turmeric', 'Ginger', 'Licorice Root'],
  'Digestive Support Tea': ['Peppermint', 'Fennel', 'Ginger'],
  'Floral Mint Infusion': ['Rose Petals', 'Lavender', 'Peppermint'],
  'Berry Bliss Herbal Tea': ['Raspberry Leaf', 'Blackberry Leaf', 'Hibiscus'],
  'Lemon-Ginger Immune Booster': ['Lemon Peel', 'Ginger'],                                                                                                                                                                                                                                                                                                                          
  'Herbal Hibiscus Cooler': ['Hibiscus', 'Mint', 'Lemongrass'],
  'Caffeine-Free Chai': ['Cinnamon', 'Cardamom', 'Clove'],
  'Zen Herbal Blend': ['Spearmint', 'Lemon Balm', 'Lavender'],
  'Herbal Spice Tea': ['Peppermint', 'Ginger', 'Cinnamon'],
  'Berry Mint Medley': ['Raspberry Leaf', 'Mint'],
  'Stress Relief Herbal Tea': ['Lemon Balm', 'Chamomile', 'Lavender'],
  'Herbal Rose Delight': ['Rose Petals', 'Lemon Balm'],
  'Ginger Lemon Detox Tea': ['Ginger', 'Lemon Peel'],
  'Minty Floral Fusion': ['Mint', 'Rose Petals', 'Lavender'],
  'Immunity Boosting Herbal Tea': ['Echinacea', 'Ginger', 'Turmeric'],                
  'Lavender Vanilla Dream': ['Lavender', 'Vanilla Bean'],
  'Herbal Digestive Tonic': ['Peppermint', 'Ginger', 'Fennel'],
  'Energizing Herbal Infusion': ['Nettle', 'Ginseng', 'Licorice Root'],
  'Floral Ginger Blend': ['Ginger', 'Rose Petals', 'Lavender'],
  'Herbal Blueberry Bliss': ['Blueberry Leaf', 'Hibiscus'],
  'Spiced Herbal Citrus': ['Cinnamon', 'Orange Peel', 'Lemon Peel'],
  'Lavender Mint Relaxation Tea': ['Lavender', 'Peppermint'],
  'Herbal Rooibos Chai': ['Rooibos', 'Cinnamon', 'Cardamom', 'Ginger'],
  'Lemon Echinacea Wellness Tea': ['Lemon Peel', 'Echinacea'],
  'Soothing Rose Chamomile': ['Rose Petals', 'Chamomile', 'Lavender'],
  'Minty Nettle Detox': ['Nettle', 'Mint'],
  'Herbal Floral Medley': ['Rose Petals', 'Lavender'],
  'Herbal Citrus Delight': ['Lemon Peel', 'Orange Peel'],
  'Ginger Turmeric Anti-Inflammatory Tea': ['Ginger', 'Turmeric'],
  'Berry Hibiscus Cooler': ['Hibiscus', 'Mint', 'Lemongrass'],
  'Relaxing Lavender Lemon Balm': ['Lavender', 'Lemon Balm'],
  'Herbal Immune Support': ['Echinacea', 'Ginger', 'Turmeric'],
  'Minty Rose Herbal Tea': ['Mint', 'Rose Petals', 'Lavender'],
};

@override
  Widget build(BuildContext context) {
    List<MapEntry<String, List<String>>> sortedRecipes = [];

    herbalTeaRecipes.forEach((recipe, ingredients) {
      sortedRecipes.add(MapEntry(recipe, ingredients));
    });

    sortedRecipes.sort((a, b) {
      int aMatchingIngredients = a.value.where((ingredient) => widget.selectedHerbs.contains(ingredient)).length;
      int bMatchingIngredients = b.value.where((ingredient) => widget.selectedHerbs.contains(ingredient)).length;
      return bMatchingIngredients.compareTo(aMatchingIngredients);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Tea Recipes'),
        backgroundColor: Colors.grey[900],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '* denotes previously selected ingredients',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sortedRecipes.length,
              itemBuilder: (context, index) {
                final recipeEntry = sortedRecipes[index];
                final recipeTitle = recipeEntry.key;
                final ingredients = recipeEntry.value;

                return ListTile(
                  title: Text(recipeTitle),  
                  subtitle: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: ingredients.map((ingredient) {
                            return widget.selectedHerbs.contains(ingredient)
                                ? '$ingredient*'
                                : ingredient;
                          }).join(', '),
                        ),
                      ],
                    ),
                  ),
                  trailing: IconButton(
  icon: Icon(Icons.copy),
  onPressed: () {
    final recipeText = '$recipeTitle\nIngredients: ${ingredients.join(', ')}';
    _saveNotes(recipeText); // Call the function to save copied recipe
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Recipe saved')),
    );
  },
),

                  onTap: () {
                    // TODO: Implement a way to show the recipe details
                    // You can navigate to a detailed recipe page or display a modal bottom sheet
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

    // Append the copied recipe to the existing content
    final copiedRecipe = '===NoteDelimiter===$message';
    await file.writeAsString(copiedRecipe, mode: FileMode.append);
  } catch (e) {
    // Handle errors
  }
}
}