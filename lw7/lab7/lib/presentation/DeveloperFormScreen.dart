import 'package:flutter/material.dart';
import '../data/javaDeveloper.dart';
import '../data/db.dart';


class DeveloperFormScreen extends StatefulWidget {
  final JavaDeveloper? developer;

  const DeveloperFormScreen({Key? key, this.developer}) : super(key: key);

  @override
  _DeveloperFormScreenState createState() => _DeveloperFormScreenState();
}

class _DeveloperFormScreenState extends State<DeveloperFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _specialty;

  @override
  void initState() {
    super.initState();
    if (widget.developer != null) {
      _name = widget.developer!.name;
      _specialty = widget.developer!.specialty;
    } else {
      _name = '';
      _specialty = 'Java';
    }
  }

  void _saveDeveloper() {
    if (_formKey.currentState!.validate()) {
      final developer = JavaDeveloper(
        id: widget.developer?.id,
        name: _name,
        specialty: _specialty,
      );

      if (widget.developer == null) {
        DatabaseHelper()
            .insertDeveloper(developer)
            .then((_) => Navigator.pop(context));
      } else {
        DatabaseHelper()
            .updateDeveloper(developer)
            .then((_) => Navigator.pop(context));
      }
    }
  }

  void _deleteDeveloper() {
    if (widget.developer != null) {
      DatabaseHelper()
          .deleteDeveloper(widget.developer!.id!)
          .then((_) => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.developer == null
            ? 'Добавить разработчика'
            : 'Редактировать разработчика'),
        actions: widget.developer != null
            ? [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: _deleteDeveloper,
                ),
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Имя'),
                initialValue: _name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите имя';
                  }
                  return null;
                },
                onChanged: (value) {
                  _name = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Специальность'),
                initialValue: _specialty,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите специальность';
                  }
                  return null;
                },
                onChanged: (value) {
                  _specialty = value;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveDeveloper,
                child: const Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
