import 'dart:io';

import 'package:herbal_tea_assistant/recipes_page.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';


class IngredientsPage extends StatefulWidget {
  @override
  _IngredientsPageState createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  List<String> selectedHerbs = [];
  List<String> commonHerbs = [
'Alfalfa','Aloe Vera','Anise','Basil','Blackberry Leaf','Blueberry Leaf','Borage','Calendula','Cardamom','Catnip','Chamomile','Chervil','Chives','Cilantro','Cilantro','Cinnamon','Clove','Comfrey','Coriander','Dandelion','Dill','Echinacea','Elderberry','Fennel','Feverfew','Garlic','Ginger','Ginseng','Goldenseal','Gotu Kola','Hibiscus','Hyssop','Lavender','Lavender','Lemon Balm','Lemon Peel','Lemongrass','Licorice Root','Marjoram','Mint','Nettle','Orange Peel','Oregano','Parsley','Parsley','Passionflower','Peppermint','Plantain','Raspberry Leaf','Rooibos','Rose Petals','Rosemary','Sage','Sage','Spearmint','St. John\'s Wort','Thyme','Turmeric','Turmeric','Valerian','Vanilla Bean','Yarrow'
  ];

  TextEditingController _searchController = TextEditingController();
  List<String> filteredHerbs = [];

  bool _isExpanded = false;

  void _searchHerbs(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredHerbs = commonHerbs;
      } else {
        filteredHerbs = commonHerbs
            .where((herb) => herb.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _openInstacart(String ingredient) async {
    final instacartUrl = 'https://www.instacart.com/storefronts?q=${Uri.encodeComponent(ingredient)}';

    if (await canLaunch(instacartUrl)) {
      await launch(instacartUrl);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Unable to open Instacart.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }


void _saveHerb(String message) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/ingredients.txt');

    // Append the copied recipe to the existing content
    final copiedRecipe = '===NoteDelimiter===$message';
    await file.writeAsString(copiedRecipe, mode: FileMode.append);
  } catch (e) {
    // Handle errors
  }
}


void _openWalmart(String herb) async {
  final walmartUrl = 'https://www.walmart.com/search/?query=$herb';
  if (await canLaunch(walmartUrl)) {
    await launch(walmartUrl);
  } else {
   showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Unable to open Walmart.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
  }
}

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Browse Ingredients'),
          content: Text('Look up commonly used herbs here. Use the \'Selected Herbs\' widget to view selected herbs. These herbs can be purchased on Instacart and Walmart, or saved using the respective icons. Use the \'Show Recipes\' icon to view recipes.'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse Ingredients'),
        backgroundColor: Colors.grey[900],
          actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Herbs',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _searchHerbs,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ExpansionPanelList(
                  expandedHeaderPadding: EdgeInsets.zero,
                  elevation: 1,
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      _isExpanded = !isExpanded;
                    });
                  },
                  children: [
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text('Selected Herbs'),
                        );
                      },
                      body: Column(
                        children: selectedHerbs.map((herb) {
                          return ListTile(
                            title: Text(
                              herb,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.shopping_cart),
                                  onPressed: () {
                                    _openInstacart(herb);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.shopping_bag),
                                  onPressed: () {
                                    _openWalmart(herb);
                                  },
                                ),
                                 IconButton(
                                  icon: Icon(Icons.save_alt),
                                  onPressed: () {
                                    _saveHerb(herb);
                                  },
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      isExpanded: _isExpanded,
                    ),
                  ],
                ),
                Divider(),
                ...filteredHerbs.map((herb) {
                  return CheckboxListTile(
                    title: Text(herb),
                    value: selectedHerbs.contains(herb),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          if (value) {
                            selectedHerbs.add(herb);
                          } else {
                            selectedHerbs.remove(herb);
                          }
                        });
                      }
                    },
                  );
                }).toList(),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipesPage(selectedHerbs: selectedHerbs),
                ),
              );
            },
            child: Text('Show Recipes'),
          ),
        ],
      ),
    );
  }
}