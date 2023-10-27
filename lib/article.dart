import 'package:flutter/material.dart';

import 'article_display_page.dart';

class Article {
  final String title;
  final String content;
  final DateTime datePosted;

  Article({required this.title, required this.content, required this.datePosted});
}

class ArticleTile extends StatelessWidget {
  final Article article;

  ArticleTile({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        title: Text(article.title),
        subtitle: Text(article.datePosted.toLocal().toString()),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ArticleDisplayPage(article: article)),
          );
        },
      ),
    );
  }
}
