import 'package:flutter/services.dart' show rootBundle;
import 'article.dart';

Future<List<Article>> loadArticlesFromFiles() async {
  List<Article> articles = [];

  List<String> articleFiles = ['lib/articles/green_tea.txt', 'lib/articles/chamomile_tea.txt', 'lib/articles/peppermint_tea.txt', 'lib/articles/black_tea.txt', 'lib/articles/matcha_green_tea.txt', 'lib/articles/bibliography.txt'];

  for (String path in articleFiles) {
    String content = await rootBundle.loadString(path);
    List<String> lines = content.split(',');

    String title = lines[0].trim();
    DateTime date = DateTime.parse(lines[1].trim());
    String articleContent = content.split('\n').sublist(2).join('\n\n').trim();

    articles.add(Article(title: title, content: articleContent, datePosted: date));
  }
  return articles;
}