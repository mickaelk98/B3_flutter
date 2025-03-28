import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  List<String> postTitles = [];
  List<int> postIds = [];

  @override
  void initState() {
    super.initState();
    fetchPosts(); // Appel de la fonction pour récupérer les données
  }

  // Fonction pour récupérer les titres et les IDs des posts
  Future<void> fetchPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        postTitles = data.map((post) => post['title'] as String).toList();
        postIds = data.map((post) => post['id'] as int).toList();
      });
    } else {
      throw Exception('Erreur de chargement des posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Articles'),
      ),
      body: postTitles.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Affichage de la progress bar
          : ListView.builder(
              itemCount: postTitles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(postTitles[index]),
                  onTap: () {
                    // Redirection vers la page de détails du post
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PostDetailPage(postId: postIds[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class PostDetailPage extends StatefulWidget {
  final int postId;

  PostDetailPage({required this.postId});

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late Map<String, dynamic> postDetails;

  @override
  void initState() {
    super.initState();
    postDetails = {};
    fetchPostDetails();
  }

  // Fonction pour récupérer les détails du post
  Future<void> fetchPostDetails() async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts/${widget.postId}'));

    if (response.statusCode == 200) {
      setState(() {
        postDetails = json.decode(response.body);
      });
    } else {
      throw Exception('Erreur de chargement du post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Post'),
      ),
      body: postDetails.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    postDetails['title'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    postDetails['body'],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
    );
  }
}
