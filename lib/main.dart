import 'package:chatgpt_client/api/chat_api.dart';
import 'package:chatgpt_client/chat_page.dart';
import 'package:chatgpt_client/home_page.dart'; 
import 'package:chatgpt_client/secrets.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Secrets.initializeApiKey();
  runApp(ChatApp(chatApi: ChatApi()));
}

class ChatApp extends StatelessWidget {
  const ChatApp({required this.chatApi, super.key});

  final ChatApi chatApi;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepOrange,
          backgroundColor: Colors.grey[900],
        ),
      ),
      home: const HomePage(),
      routes: {
        '/chat': (context) => ChatPage(chatApi: chatApi),
      },
    );
  }
}
