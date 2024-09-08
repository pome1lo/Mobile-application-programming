import 'dart:async' show Future;

// Асинхронная функция, имитирующая получение данных
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2)); // Задержка 2 секунды
  return 'Data fetched';
}

void main() async {
  print('Fetching data...');

  // Использование Future для ожидания результата
  fetchData().then((data) {
    print(data); // Выводим полученные данные
  }).catchError((error) {
    print('An error occurred: $error'); // Обработка ошибок
  }).whenComplete(() {
    print('Fetch data operation completed'); // Действие по завершении
  });

  // Альтернативный способ с использованием async/await
  try {
    String data = await fetchData();
    print(data); // Выводим полученные данные
  } catch (error) {
    print('An error occurred: $error'); // Обработка ошибок
  } finally {
    print('Fetch data operation completed'); // Действие по завершении
  }
}
