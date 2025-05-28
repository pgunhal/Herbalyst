// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:herbal_tea_assistant/widgets/list_tiles.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'ingredients_page.dart';

class SavedIngredientsPage extends StatefulWidget {
  @override
  _SavedIngredientsPageState createState() => _SavedIngredientsPageState();
}

class _SavedIngredientsPageState extends State<SavedIngredientsPage> {
  // final TextEditingController _textEditingController = TextEditingController();
  final List<String> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/ingredients.txt');
      if (await file.exists()) {
        final content = await file.readAsString();
        setState(() {
          _notes.clear();
          _notes.addAll(content.split('===NoteDelimiter==='));
        });
      }
    } catch (e) {
      // Handle errors
    }
  }

  void _saveNotes() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/ingredients.txt');
      final content = _notes.join('===NoteDelimiter===');
      await file.writeAsString(content);
    } catch (e) {
      // Handle errors
    }
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
      _saveNotes();
    });
  }

    void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Saved Ingredients'),
          content: const Text('Save ingredients in this shopping list. Items are automatically crossed out when selected. Swipe left to delete. Use the \'Browse Ingredients\' icon to look up commonly used herbs.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Ingredients'),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                final isChecked = note.contains("checked");
                final ingredient = isChecked ? note.replaceAll(" (checked)", "") : note;

                return Dismissible(
                  key: Key(note),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => _deleteNote(index),
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: CheckboxListTile(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        final updatedNote = value == true ? "$ingredient (checked)" : ingredient;
                        _notes[index] = updatedNote;
                        _saveNotes();
                      });
                    },
                    title: Text(
                      ingredient,
                      style: TextStyle(
                        decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(50),
            child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IngredientsPage(),
                ),
              );
            },
            child: const Text('Browse Ingredients'),
          ),)
        ],
      ),
    );
  }
}
