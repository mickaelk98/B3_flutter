import 'package:flutter/material.dart';
import '../controllers/article_controller.dart';
import '../models/article_model.dart';

class ArticleDetailPage extends StatefulWidget {
  final int articleId;

  ArticleDetailPage({required this.articleId});

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final ArticleController articleController = ArticleController();
  late Future<Article> futureArticle;

  @override
  void initState() {
    super.initState();
    futureArticle = articleController.fetchArticleById(widget.articleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de l\'Article'),
      ),
      body: FutureBuilder<Article>(
        future: futureArticle,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Article introuvable'));
          }

          Article article = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  article.body,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
