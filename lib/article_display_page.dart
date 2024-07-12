// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'article.dart';  // Make sure to import the Article model

class ArticleDisplayPage extends StatelessWidget {
  final Article article;

  ArticleDisplayPage({required this.article});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
          foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _formatDate(article.datePosted.toLocal()).toString(),
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              Text(article.content, style: TextStyle(color: Colors.grey[900])),
            ],
          ),
        ),
      ),
    );
  }
}

  String _formatDate(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }