import 'package:flutter/material.dart';
import '../controllers/article_controller.dart';
import '../models/article_model.dart';
import 'article_detail_page.dart';

class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  final ArticleController articleController = ArticleController();
  late Future<List<Article>> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = articleController.fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Articles'),
      ),
      body: FutureBuilder<List<Article>>(
        future: futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun article disponible'));
          }

          List<Article> articles = snapshot.data!;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(articles[index].title),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ArticleDetailPage(articleId: articles[index].id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
