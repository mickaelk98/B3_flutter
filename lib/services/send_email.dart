import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendEmail(
    {required String name,
    required String email,
    required String message}) async {
  await dotenv.load(); // Charger les variables d'environnement depuis .env

  final String? serviceId = dotenv.env['SERVICE_ID'];
  final String? templateId = dotenv.env['TEMPLATE_ID'];
  final String? userId = dotenv.env['PUBLIC_KEEY'];

  // verifie que les variables d'environnement sont bien définies
  if (serviceId == null || templateId == null || userId == null) {
    print(
        'Erreur : Les identifiants EmailJS ne sont pas définis dans le fichier .env');
    return;
  }

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'name': name,
        'message': message,
        'email': email,
      }
    }),
  );

  if (response.statusCode == 200) {
    print('E-mail envoyé avec succès !');
  } else {
    print('Erreur lors de l\'envoi : ${response.body}');
  }
}
