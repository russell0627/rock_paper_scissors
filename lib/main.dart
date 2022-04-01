import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'utils/roller.dart';

// TODO: Add a feature to show the enemy's selection when the throw button is clicked.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock Paper Scissors',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Rock Paper Scissors'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String gameOutcome = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(gameOutcome),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Rock Beats Scissors\nScissors Beat Paper\nPaper Beats Rock",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => playGame(GameOption.rock),
                  icon: const Icon(FontAwesomeIcons.mound),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () => playGame(GameOption.paper),
                    icon: const Icon(FontAwesomeIcons.scroll),
                  ),
                ),
                IconButton(
                  onPressed: () => playGame(GameOption.scissors),
                  icon: const Icon(FontAwesomeIcons.scissors),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GameOption _createEnemyGameOption() => GameOption.values[rollDie(3) - 1];

  void playGame(GameOption userOption,) {
    setState(() {
      final enemyGameOption = _createEnemyGameOption();

      if (userOption == enemyGameOption) {
        gameOutcome = "Its a tie!";
      } else if (userOption == GameOption.rock && enemyGameOption == GameOption.scissors) {
        gameOutcome = "You win!";
      } else if (userOption == GameOption.rock && enemyGameOption == GameOption.paper) {
        gameOutcome = "Enemy wins with ${enemyGameOption.name}!";
      } else if (userOption == GameOption.scissors && enemyGameOption == GameOption.paper) {
        gameOutcome = "You win!";
      } else if (enemyGameOption == GameOption.rock && userOption == GameOption.scissors) {
        gameOutcome = "Enemy wins with ${enemyGameOption.name}!";
      } else {
        gameOutcome = "Enemy wins with ${enemyGameOption.name}!";
      }
    });
  }
}

enum GameOption {
  rock,
  paper,
  scissors,
}
