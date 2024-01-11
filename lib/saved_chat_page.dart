import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SavedRecipesPage extends StatefulWidget {
  @override
  _SavedRecipesPageState createState() => _SavedRecipesPageState();
}

class _SavedRecipesPageState extends State<SavedRecipesPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

void _loadNotes() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/recipes.txt');
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
    final file = File('${directory.path}/recipes.txt');
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
          title: Text('Saved Notes'),
          content: Text('View saved messages from chat here. You can also add custom notes. Swipe left to delete notes.'),
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
        title: const Text('Saved Notes'),
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
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
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
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      title: Text(note),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(labelText: 'Enter your note here'),
              onSubmitted: (text) {
                setState(() {
                  _notes.add(text);
                  _saveNotes();
                });
                _textEditingController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
