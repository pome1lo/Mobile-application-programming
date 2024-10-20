import 'package:flutter/material.dart';
import '../models/athlete.dart';
import '../db/database_helper.dart';
import 'add_edit_athlete_screen.dart';

class AthleteListScreen extends StatefulWidget {
  @override
  _AthleteListScreenState createState() => _AthleteListScreenState();
}

class _AthleteListScreenState extends State<AthleteListScreen> {
  List<Athlete> athletes = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadAthletes();
  }

  void _loadAthletes() async {
    final loadedAthletes = await _dbHelper.getAthletes();
    setState(() {
      athletes = loadedAthletes;
    });
  }

  void _navigateToAddEditScreen([Athlete? athlete, int? index]) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditAthleteScreen(
          athlete: athlete,
          index: index, // Здесь мы передаём index, если он нужен
        ),
      ),
    );
    if (result != null) {
      _loadAthletes();
    }
  }

  void _deleteAthlete(int index) async {
    int? athleteId = athletes[index].id;

    if (athleteId != null) {
      await _dbHelper.deleteAthlete(athleteId);
      _loadAthletes(); // Перезагрузка списка после удаления
    } else {
      print('Error: Athlete ID is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Athletes'),
      ),
      body: ListView.builder(
        itemCount: athletes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(athletes[index].name),
            subtitle: Text('${athletes[index].sport} (Score: ${athletes[index].score})'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _navigateToAddEditScreen(athletes[index], index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteAthlete(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddEditScreen(),
        child: Icon(Icons.add),
      ),
    );
  }
}
