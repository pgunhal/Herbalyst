import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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

 
  String _searchQuery = '';
  TextEditingController _searchController = TextEditingController();

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

  List<MapEntry<String, List<String>>> _getFilteredRecipes() {
    if (_searchQuery.isEmpty) {
      return herbalTeaRecipes.entries.toList();
    } else {
      return herbalTeaRecipes.entries
        .where((entry) => entry.key.toLowerCase().contains(_searchQuery) ||
                          entry.value.any((ingredient) => ingredient.toLowerCase().contains(_searchQuery)))
        .toList();
    }
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Browse recipes'),
          content: Text('Browse a wide range of custom herbal teas, sorted by ingredients. Search for teas matching your preferences at the top. Save your favorites for later using the save button. You can view saved recipes in \'Saved Notes\'.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, List<String>>> filteredRecipes = _getFilteredRecipes();

    return Scaffold(
      appBar: AppBar(
        title: Text('Browse Recipes'),
          foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
         actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
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
                final ingredients = recipeEntry.value;

                return ListTile(
                  title: Text(recipeTitle),
                  subtitle: Text(ingredients.join(', ')),
                  trailing: IconButton(
                    icon: Icon(Icons.save_alt),
                    onPressed: () {
                      final recipeText = '$recipeTitle\nIngredients: ${ingredients.join(', ')}';
                      _saveNotes(recipeText);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Recipe saved')),
                      );
                    },
                  ),
                  onTap: () {
                    // TODO: Implement recipe detail view if necessary
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