// main.dart
import 'package:flutter/material.dart';
import 'screens/athlete_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sport App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AthleteListScreen(),
    );
  }
}
