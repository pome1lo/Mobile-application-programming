import 'package:flutter/material.dart';
import 'package:lw2/sport.dart';

void main() {
  // 10 variant


  Football football = Football('Football', 11);
  Football defaultFootball = Football.withDefaultPlayers('Football');

  // Демонстрация работы с массивом, коллекцией и множеством
  List<Football> footballTeams = [football, defaultFootball];
  Set<String> teamNames = {'Team A', 'Team B', 'Team C'};
  Map<String, int> teamScores = {'Team A': 1, 'Team B': 2};

  // Работа с continue и break
  for (var team in footballTeams) {
    if (team.players < 11) {
      continue; // Пропустить команды с менее чем 11 игроками
    }
    print('Team with ${team.players} players.');
    if (team.players == 11) {
      break; // Прекратить цикл, если команда имеет 11 игроков
    }
  }

  // Обработка исключений
  try {
    football.play();
    football.substitutePlayer('Player 1');
    football.performAction(() => print('Action performed.'));
    football.showTeam(teamName: 'Champions');
    Football.showSportType();
    throw Exception(";(");
  } catch (e) {
    print('An error occurred: $e');
  }

  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
