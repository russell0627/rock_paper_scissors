import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'utils/roller.dart';

// TODO: Add a feature to show the enemy's selection when the throw button is clicked.

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Rock Paper Scissors',
      home: HomePage(title: 'Rock Paper Scissors'),
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
  String _gameOutcome = "";
  late GameOption _enemyGameOption;
  bool gameStarted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => setState(() {
                      gameStarted = false;
                      _gameOutcome = "";
                    }),
                icon: const Icon(Icons.refresh)),
            Text("Enemy option: ${gameStarted ? _enemyGameOption.name : "You can't see this yet!"}", style: const TextStyle(fontSize: 20, ),),
            Text(_gameOutcome),
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

  GameOption createEnemyGameOption() => GameOption.values[rollDie(3) - 1];

  void playGame(
    GameOption userOption,
  ) {
    setState(() {
      final enemyGameOption = createEnemyGameOption();

      if (userOption == enemyGameOption) {
        _gameOutcome = "Its a tie!";
      } else if (userOption == GameOption.rock && enemyGameOption == GameOption.scissors) {
        _gameOutcome = "You win!";
      } else if (userOption == GameOption.rock && enemyGameOption == GameOption.paper) {
        _gameOutcome = "Enemy wins with ${enemyGameOption.name}!";
      } else if (userOption == GameOption.scissors && enemyGameOption == GameOption.paper) {
        _gameOutcome = "You win!";
      } else if (enemyGameOption == GameOption.rock && userOption == GameOption.scissors) {
        _gameOutcome = "Enemy wins with ${enemyGameOption.name}!";
      } else {
        _gameOutcome = "Enemy wins with ${enemyGameOption.name}!";
      }

      _enemyGameOption = enemyGameOption;
      gameStarted = true;
    });
  }
}

enum GameOption {
  rock,
  paper,
  scissors,
}
