import 'package:flutter/material.dart';
import 'package:lab7/presentation/FileSystemScreen.dart';
import '../data/db.dart';
import '../data/javaDeveloper.dart';
import 'DeveloperFormScreen.dart';

class DeveloperListScreen extends StatefulWidget {
  @override
  _DeveloperListScreenState createState() => _DeveloperListScreenState();
}

class _DeveloperListScreenState extends State<DeveloperListScreen> {
  late Future<List<JavaDeveloper>> _developers;

  @override
  void initState() {
    super.initState();
    _developers = DatabaseHelper().getDevelopers();
  }

  void _refreshDevelopers() {
    setState(() {
      _developers = DatabaseHelper().getDevelopers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список разработчиков'),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_present),
            tooltip: 'Работа с файлами',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FileSystemScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeveloperFormScreen()),
              ).then((_) => _refreshDevelopers());
            },
          ),
        ],
      ),
      body: FutureBuilder<List<JavaDeveloper>>(
        future: _developers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет разработчиков'));
          } else {
            final developers = snapshot.data!;
            return ListView.builder(
              itemCount: developers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(developers[index].name),
                  subtitle: Text(developers[index].specialty),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeveloperFormScreen(developer: developers[index]),
                      ),
                    ).then((_) => _refreshDevelopers());
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}