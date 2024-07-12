// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:herbal_tea_assistant/api/chat_api.dart';
import 'package:herbal_tea_assistant/models/chat_message.dart';
import 'package:herbal_tea_assistant/secrets.dart';
import 'package:herbal_tea_assistant/widgets/message_bubble.dart';
import 'package:herbal_tea_assistant/widgets/message_composer.dart';
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
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    _loadChatMessages();
  }

    @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
        title: const Text('Clear Chat'),
        content: const Text('Are you sure you want to clear the chat? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Clear'),
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

  // void _scrollToBottom() {
  //   if (_scrollController.hasClients) {
  //     _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  //   }
  // }

  
  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chat'),
          content: const Text('Ask your personal AI assistant for recommendations, tailored recipes, and more. Save your favorite messages by pressing the \'save\' button. You can view saved messages in \'Saved Notes\'.'),
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
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900], // Set background color
        title: const Text(
          'Chat',
          style: TextStyle(
            fontWeight: FontWeight.bold,// Set text color
            fontSize: 24,
          ),
        ),
        actions: [
           IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          ),
          IconButton(
            onPressed: _clearChat,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
body: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              controller: _scrollController,
              children: _messages.reversed
                  .map((msg) => MessageBubble(
                        content: msg.content,
                        isUserMessage: msg.isUserMessage,
                        showSaveButton: !msg.isUserMessage,
                        onSave: () => _saveResponse(msg.content),
                      ))
                  .toList(),
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
        print('API Response: $response'); // Debug: Print the full response

    setState(() {
      _messages.add(ChatMessage(response, false));
      _awaitingResponse = false;
    });
    _saveChatMessages(); // Save the updated chat messages
  } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(err.toString())),
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
      final file = File('${directory.path}/recipes.txt');
      // final userMessages = _messages.where((msg) => msg.isUserMessage).map((msg) => msg.content).join('\n');
      await file.writeAsString(message);
    } catch (e) {
      // print('Error saving notes: $e');
    }
  }
}
