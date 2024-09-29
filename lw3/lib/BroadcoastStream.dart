import 'dart:async';

Stream<int> broadcastStream(int max) {
  StreamController<int> controller = StreamController<int>.broadcast();

  Future(() {
    for (int i = 1; i <= max; i++) {
      controller.add(i);
    }
    controller.close();
  });

  return controller.stream;
}

void main() {
  Stream<int> stream = broadcastStream(5);

  // Подписка на BroadcastStream
  stream.listen((value) => print('Broadcast stream listener 1: $value'));
  stream.listen((value) => print('Broadcast stream listener 2: $value'));
}
