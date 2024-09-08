import 'dart:async';

// Функция, создающая BroadcastStream
Stream<int> broadcastStream(int max) {
  StreamController<int> controller = StreamController<int>.broadcast();

  // Добавляем значения в поток с задержкой
  Future(() {
    for (int i = 1; i <= max; i++) {
      controller.add(i);
    }
    controller.close(); // Закрываем поток после добавления всех значений
  });

  return controller.stream;
}

void main() {
  // Создание BroadcastStream
  Stream<int> stream = broadcastStream(5);

  // Подписка на BroadcastStream
  stream.listen((value) => print('Broadcast stream listener 1: $value'));
  stream.listen((value) => print('Broadcast stream listener 2: $value'));
}
