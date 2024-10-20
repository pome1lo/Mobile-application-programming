// services/file_service.dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileService {
  // Метод для сохранения данных в файл
  Future<void> writeFile(String content, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsString(content);
  }

  // Метод для чтения данных из файла
  Future<String> readFile(String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');
      return await file.readAsString();
    } catch (e) {
      return 'Error reading file: $e';
    }
  }
}
