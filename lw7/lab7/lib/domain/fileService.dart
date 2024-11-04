import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

import '../data/javaDeveloper.dart';

class FileService {
  final Map<String, String> directoryLanguageMap = {
    'Temporary': 'Java',
    'Application Support': 'C#',
    'Application Library': 'Python',
    'Application Documents': 'JavaScript',
    'Application Cache': 'Kotlin',
    'External Storage': 'Swift',
    'External Cache Directories': 'Ruby',
    'External Storage Directories': 'Go',
    'Downloads': 'PHP',
  };


  String _developersToJson(List<JavaDeveloper> developers) {
    final List<Map<String, dynamic>> data =
    developers.map((developer) => developer.toJson()).toList();
    return jsonEncode(data);
  }

  List<JavaDeveloper> _jsonToDevelopers(String jsonStr) {
    final List<dynamic> data = jsonDecode(jsonStr);
    return data.map((item) => JavaDeveloper.fromJson(item)).toList();
  }

  Future<Directory> _getDirectory(String dirType) async {
    switch (dirType) {
      case 'Temporary':
        return await getTemporaryDirectory();
      case 'Application Support':
        return await getApplicationSupportDirectory();
      case 'Application Library':
        return await getApplicationSupportDirectory();
      case 'Application Documents':
        return await getApplicationDocumentsDirectory();
      case 'Application Cache':
        return await getApplicationCacheDirectory();
      case 'External Storage':
        return Directory('/storage/emulated/0/');
      case 'External Cache Directories':
        return (await getExternalCacheDirectories())!.first;
      case 'External Storage Directories':
        return (await getExternalStorageDirectories())!.first;
      case 'Downloads':
        return Directory('/storage/emulated/0/Download');
      default:
        throw ArgumentError('Неизвестный тип директории: $dirType');
    }
  }

  Future<void> writeDevelopersToDirectory(String dirType, List<JavaDeveloper> developers) async {
    try {
      final directory = await _getDirectory(dirType);
      final language = directoryLanguageMap[dirType] ?? 'Unknown';
      final filePath = '${directory.path}/developers_$language.json';
      final file = File(filePath);
      final jsonStr = _developersToJson(developers);
      await file.writeAsString(jsonStr);
      if (kDebugMode) {
        print('Данные записаны в $filePath');
      }
    } catch (e) {
      debugPrint('Ошибка при записи в директорию $dirType: $e');
      throw Exception('Не удалось записать данные в директорию $dirType');
    }
  }

  Future<List<JavaDeveloper>> readDevelopersFromDirectory(String dirType) async {
    try {
      final directory = await _getDirectory(dirType);
      final language = directoryLanguageMap[dirType] ?? 'Unknown';
      final filePath = '${directory.path}/developers_$language.json';
      final file = File(filePath);
      if (await file.exists()) {
        final jsonStr = await file.readAsString();
        return _jsonToDevelopers(jsonStr);
      } else {
        if (kDebugMode) {
          print('Файл не найден: $filePath');
        }
        return [];
      }
    } catch (e) {
      debugPrint('Ошибка при чтении из директории $dirType: $e');
      throw Exception('Не удалось прочитать данные из директории $dirType');
    }
  }
}
