import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthPage Tests', () {
    late MockFirebaseAuth mockAuth;

    setUp(() {
      mockAuth = MockFirebaseAuth();
    });

    test('Successful login with email and password', () async {
      // Настройка моков для теста
      final user = MockUser(
        email: 'example@gmail.com',
        displayName: 'Test User',
      );
      mockAuth = MockFirebaseAuth(mockUser: user);

      final userCredential = await mockAuth.signInWithEmailAndPassword(
        email: 'example@gmail.com',
        password: '123456',
      );

      // Проверяем результат
      expect(userCredential.user?.email, 'example@gmail.com');
      expect(userCredential.user?.displayName, 'Test User');
    });
  });
}
