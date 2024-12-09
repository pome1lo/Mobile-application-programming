import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'firebase_messaging_test.mocks.dart';

// Аннотация для генерации моков
@GenerateMocks([FirebaseMessaging])
void main() {
  group('Firebase Messaging Tests', () {
    late MockFirebaseMessaging mockMessaging;

    setUp(() {
      mockMessaging = MockFirebaseMessaging();
    });

    test('Get FCM Token', () async {
      // Настройка моков
      when(mockMessaging.getToken()).thenAnswer((_) async => 'test_token');

      // Вызов метода
      final token = await mockMessaging.getToken();

      // Проверка результата
      expect(token, equals('test_token'));
      verify(mockMessaging.getToken()).called(1);
    });
  });
}
