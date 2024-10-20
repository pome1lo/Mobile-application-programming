// screens/add_edit_athlete_screen.dart
import 'package:flutter/material.dart';
import '../models/athlete.dart';
import '../db/database_helper.dart';

class AddEditAthleteScreen extends StatefulWidget {
  final Athlete? athlete; // Передаем существующего спортсмена, если редактируем
  final int? index; // Если вы хотите использовать index, добавьте его

  const AddEditAthleteScreen({Key? key, this.athlete, this.index}) : super(key: key);


  @override
  _AddEditAthleteScreenState createState() => _AddEditAthleteScreenState();
}

class _AddEditAthleteScreenState extends State<AddEditAthleteScreen> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  String? _name;
  String? _sport;
  int? _score;

  @override
  void initState() {
    super.initState();
    if (widget.athlete != null) {
      _name = widget.athlete!.name;  // Загружаем данные спортсмена
      _sport = widget.athlete!.sport;
      _score = widget.athlete!.score;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.athlete == null ? 'Add Athlete' : 'Edit Athlete'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _sport,
                decoration: InputDecoration(labelText: 'Sport'),
                onSaved: (value) => _sport = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a sport';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _score?.toString(),
                decoration: InputDecoration(labelText: 'Score'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _score = int.tryParse(value ?? '0') ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a score';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Создаем объект спортсмена с новыми данными
                    final athlete = Athlete(
                      id: widget.athlete?.id, // Важно передать id для обновления
                      name: _name!,
                      sport: _sport!,
                      score: _score ?? 0,
                    );

                    if (widget.athlete == null) {
                      // Добавляем нового спортсмена
                      _dbHelper.insertAthlete(athlete);
                    } else {
                      // Обновляем существующего спортсмена
                      _dbHelper.updateAthlete(athlete);
                    }
                    Navigator.pop(context, true); // Возвращаемся назад
                  }
                },
                child: Text(widget.athlete == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
