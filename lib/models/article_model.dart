// Model Article representant la donnée recu de l'api, transformée en objet
class Article {
  final int userId;
  final int id;
  final String title;
  final String body;

  Article(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body});

  // Convertir le json qu'on recoit de l'api en objet
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}
