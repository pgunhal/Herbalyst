import 'package:chatgpt_client/api/chat_api.dart';
import 'package:chatgpt_client/models/chat_message.dart';
import 'package:chatgpt_client/secrets.dart';
import 'package:chatgpt_client/widgets/message_bubble.dart';
import 'package:chatgpt_client/widgets/message_composer.dart';
import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    required this.chatApi,
    super.key,
  });

  final ChatApi chatApi;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messages = <ChatMessage>[];
  var _awaitingResponse = false;

  @override
  void initState() {
    super.initState();
    _loadChatMessages();
  }

  Future<void> _loadChatMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedMessages = prefs.getStringList('chat_messages') ?? [];
      setState(() {
        _messages.addAll(savedMessages.map((msg) {
          final parts = msg.split(':');
          return ChatMessage(parts[1], parts[0] == 'user');
        }));
      });
      OpenAI.apiKey = Secrets.apiKey;
    } catch (e) {
      print('Error loading chat messages: $e');
    }
  }


  

  Future<void> _clearChat() async {
    final confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear Chat'),
        content: Text('Are you sure you want to clear the chat? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Clear'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        _messages.clear();
        _messages.add(ChatMessage('Hello, how can I help?', false)); // Add the default message
        _saveChatMessages();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900], // Set background color
        title: Text(
          'Chat',
          style: TextStyle(
            fontWeight: FontWeight.bold,// Set text color
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _clearChat,
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ..._messages.map(
                  (msg) => MessageBubble(
                    content: msg.content,
                    isUserMessage: msg.isUserMessage,
                    showSaveButton: !msg.isUserMessage, // Show save button for non-user messages
                    onSave: () => _saveResponse(msg.content),
                  ),
                ),
              ],
            ),
          ),
          MessageComposer(
            onSubmitted: _onSubmitted,
            awaitingResponse: _awaitingResponse,
          ),
        ],
      ),
    );
  }


Future<void> _onSubmitted(String message) async {
  setState(() {
    _messages.add(ChatMessage(message, true));
    _awaitingResponse = true;
  });

  try {
    final response = await widget.chatApi.completeChat(_messages);
    setState(() {
      _messages.add(ChatMessage(response, false));
      _awaitingResponse = false;
    });
    _saveChatMessages(); // Save the updated chat messages
  } catch (err) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('An error occurred. Please try again.')),
    );
    setState(() {
      _awaitingResponse = false;
    });
  }
}

Future<void> _saveChatMessages() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final chatMessages = _messages.map((msg) => '${msg.isUserMessage ? 'user' : 'bot'}:${msg.content}').toList();
    await prefs.setStringList('chat_messages', chatMessages);
  } catch (e) {
    print('Error saving chat messages: $e');
  }
}


  void _saveResponse(String response) {
    // Save the user message to the file
    _saveNotes(response);
  }

  void _saveNotes(String message) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/notes.txt');
      // final userMessages = _messages.where((msg) => msg.isUserMessage).map((msg) => msg.content).join('\n');
      await file.writeAsString(message);
    } catch (e) {
      // print('Error saving notes: $e');
    }
  }
}
