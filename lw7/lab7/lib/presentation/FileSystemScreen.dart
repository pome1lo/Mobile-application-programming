import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:lab7/data/db.dart';
import 'package:lab7/domain/fileService.dart';
import 'package:lab7/data/javaDeveloper.dart';



class FileSystemScreen extends StatefulWidget {
  @override
  _FileSystemScreenState createState() => _FileSystemScreenState();
}

class _FileSystemScreenState extends State<FileSystemScreen> {
  final FileService _fileService = FileService();
  bool _isLoading = false;
  String _error = '';
  Map<String, List<JavaDeveloper>> _loadedDevelopers = {};

  final List<String> _directories = [
    'Temporary',
    'Application Support',
    'Application Library',
    'Application Documents',
    'Application Cache',
    'External Storage',
    'External Cache Directories',
    'External Storage Directories',
    'Downloads',
  ];

  Future<void> _writeDevelopers(String dirType) async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final allDevelopers = await DatabaseHelper().getDevelopers();

      final language = _fileService.directoryLanguageMap[dirType];
      if (language == null) {
        throw Exception('Язык для директории $dirType не определён.');
      }

      final filteredDevelopers =
      allDevelopers.where((dev) => dev.specialty.toLowerCase() == language.toLowerCase()).toList();

      if (filteredDevelopers.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Нет разработчиков для языка $language')),
        );
        return;
      }

      await _fileService.writeDevelopersToDirectory(dirType, filteredDevelopers);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Данные успешно записаны в $dirType')),
      );
    } catch (e) {
      setState(() {
        _error = 'Ошибка при записи в $dirType: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _readDevelopers(String dirType) async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final developers = await _fileService.readDevelopersFromDirectory(dirType);
      setState(() {
        _loadedDevelopers[dirType] = developers;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Данные успешно считаны из $dirType')),
      );
    } catch (e) {
      setState(() {
        _error = 'Ошибка при чтении из $dirType: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildDevelopersList(String dirType) {
    final developers = _loadedDevelopers[dirType] ?? [];
    if (developers.isEmpty) {
      return const Text('Нет данных для отображения');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: developers.map((dev) {
        return ListTile(
          title: Text(dev.name),
          subtitle: Text('${dev.specialty} (ID: ${dev.id})'),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Работа с файловой системой'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_error.isNotEmpty)
                Text(
                  _error,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _directories.length,
                itemBuilder: (context, index) {
                  final dir = _directories[index];
                  final language = _fileService.directoryLanguageMap[dir] ?? 'Unknown';
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$dir (${language})',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => _writeDevelopers(dir),
                                icon: const Icon(Icons.save),
                                label: const Text('Записать'),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton.icon(
                                onPressed: () => _readDevelopers(dir),
                                icon: const Icon(Icons.folder_open),
                                label: const Text('Считать'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _loadedDevelopers.containsKey(dir)
                              ? _buildDevelopersList(dir)
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
