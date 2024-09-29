import 'dart:async' show Future, Stream, StreamController;

Stream<int> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 1)); // Задержка 1 секунда
  }
}

void main() async {
  // Подписка на Single subscription stream
  await for (int value in countStream(5)) {
    print('Single subscription stream: $value');
  }
}

