import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SavedChatPage extends StatefulWidget {
  @override
  _SavedChatPageState createState() => _SavedChatPageState();
}

class _SavedChatPageState extends State<SavedChatPage> {
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
    final file = File('${directory.path}/notes.txt');
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
    final file = File('${directory.path}/notes.txt');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Chat'),
        backgroundColor: Colors.grey[900],
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
