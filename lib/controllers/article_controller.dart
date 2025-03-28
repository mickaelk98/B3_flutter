import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class ArticleController {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  // Récupère tous les articles
  Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      //passe la liste d'article en json dans notre model Article et le retourne dans dans une liste d'objet Article
      return data.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Erreur de chargement des articles');
    }
  }

  // Récupère un article par son ID
  Future<Article> fetchArticleById(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      //passe l'article en json dans notre model Article et le retourne dans dans un objet Article
      return Article.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erreur de chargement de l\'article');
    }
  }
}
