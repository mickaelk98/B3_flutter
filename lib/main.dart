import 'package:flutter/material.dart';
import 'package:b3_dev/view/contact_page.dart';
import 'package:b3_dev/view/articles_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Variable pour gérer l'état du mode sombre
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      // Thème dynamique en fonction de _isDarkMode
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      darkTheme: ThemeData.dark(), // Définir le thème sombre par défaut
      themeMode:
          _isDarkMode ? ThemeMode.dark : ThemeMode.light, // Changer le theme
      home: MyHomePage(
        onThemeChanged: (bool value) {
          setState(() {
            _isDarkMode = value; // Mets a jour le theme
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Function(bool) onThemeChanged;

  MyHomePage({required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Drawer Demo'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            //listes des widgets du drawer
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Articles'),
              onTap: () {
                //Redirige vers la page des articles au clique
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArticlesPage()),
                );
              },
            ),
            ListTile(
              title: Text('Contact'),
              onTap: () {
                //Redirige vers la page contact au clique
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactPage()),
                );
              },
            ),
            ListTile(
              title: Text("Change Theme"),
              trailing: Switch(
                value: Theme.of(context).brightness ==
                    Brightness.dark, // Vérifie si le mode sombre est activé
                onChanged: (bool value) {
                  onThemeChanged(value);
                },
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //Centre le contenu
          crossAxisAlignment: CrossAxisAlignment.center, //Centre le contenu
          children: [
            Text(
              'Bienvenue sur mon application flutter, l\'objectif de cette application est d\'apprendre a utiliser flutter via different exercice',
            ),
            Image(image: AssetImage('assets/images/bg.jpg')),
          ],
        ),
      ),
    );
  }
}
