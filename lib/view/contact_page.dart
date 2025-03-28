import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/send_email.dart'; // Import de ta fonction d'envoi d'email

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFormData();
  }

  // Charger les données enregistrées localement
  Future<void> _loadFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _messageController.text = prefs.getString('message') ?? '';
    });
  }

  // Sauvegarder les données localement
  Future<void> _saveFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _nameController.text);
    prefs.setString('email', _emailController.text);
    prefs.setString('message', _messageController.text);
  }

  // Soumettre le formulaire
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await _saveFormData(); // Sauvegarde avant envoi

      // Envoi de l'email via la fonction sendEmail
      await sendEmail(
        name: _nameController.text,
        email: _emailController.text,
        message: _messageController.text,
      );

      // Réinitialiser les champs après envoi
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();

      // Supprimer les valeurs sauvegardées
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('name');
      await prefs.remove('email');
      await prefs.remove('message');

      // Forcer la mise à jour de l'UI
      setState(() {});

      // Afficher un message de confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Message envoyé avec succès !')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contactez-nous')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(labelText: 'Message'),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre message';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Envoyer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
