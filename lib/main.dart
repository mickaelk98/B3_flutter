// Ici on importe le package material.dart, c'est le composant le plus basique dans Flutter
import 'package:flutter/material.dart';

// Ici le main, c'est le point d'entrée quand on fait du Dart
// C'est la première fonction qui est executé
void main() {
  // Ici on exécute la fonction runApp qui lance le widget MyApp
  runApp(const MyApp());
}

// Ici je définis mon widget principal de TOUTE mon application
// C'est le widget "main", c'est la ou on va avoir TOUS les widgets de TOUTE l'application
class MyApp extends StatelessWidget {
  // Ma classe MyApp hérite de StatelessWidget
  const MyApp({super.key}); // Ici le constructeur du widget

  @override // On réécrit la fonction build juste en dessous
  Widget build(BuildContext context) {
    // MaterialApp c'est le Widget qui correspond au main de toutes les pages
    return MaterialApp(
      title: 'App B3 MDS', // Ici le nom de l'application
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 9, 9, 216)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false, // Cette propriété permet de retirer le debug bar
      // La propriété home de MaterialApp correspond à la page home de notre application
      home: const MyHomePage(title: 'App B3 MDS'),
    );
  }
}

// Ici je définis mon widget MyHomePage qui est avec état
// Avec état = Il y aura un changement en temps réel côté utilisateur
class MyHomePage extends StatefulWidget {
  // Ci dessous le constructeur
  // Necessite un titre
  const MyHomePage({super.key, required this.title});

  final String title; // Le titre de la page
  // J'appelle l'état du widget

  // Ci dessous une fonction fleché (fonction à la va vite)
  // Ici elle permet de lancer une instance de _MyHomePageState plus bas
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // ici j'ai un attribut nommé _counter que j'initialise à 0

  // Ici j'ai une méthode privée nommée _incrementCounter()
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Ici on retourne une Scaffold, c'est le widget qui représente une page
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child : Text(widget.title)),
      ),
      // la propriété body attend un widget, ici on utilise le widget Center
      // Center c'est le widget qui permet de centrer des éléments
      body: Center(
        // child c'est l'élément qu'on veut centrer
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // Ci dessous, il faut mettre entre <> le type d'éléments qu'on veut lister
          children: <Widget>[
            // 1er élément => un Text
            const Text(
              'Vous avez appuyé sur le bouton :',
            ),
            // 2eme élément => un Text
            Text(
              '$_counter', // Ici j'affiche la valeur de ma propriété _counter
              style: Theme.of(context).textTheme.headlineMedium, // Ici je paramètre le thème
            ),
          ],
        ),
      ),
      // FloatingActionButton c'est un bouton qui va permettre d'effectuer une action au clic du bouton
      floatingActionButton: FloatingActionButton(
        // La propriété onPressed me permet de définir ce qui va se passer au clic du bouton
        onPressed: _incrementCounter, // Au clic, la methode _incrementCounter s'exécute
        tooltip: 'Toto', // Ce qui s'affiche au survol du bouton
        child: const Icon(Icons.add, color: Colors.pink), // icône '+' de couleur rose
      ),
    );
  }
}
