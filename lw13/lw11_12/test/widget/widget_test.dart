import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lw11_12/main.dart';

void main() {
  // Тест 1: Тестируем ввод email и пароля на странице аутентификации:
  testWidgets('Enter text in email and password fields', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');

    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.text('password123'), findsOneWidget);
  });


  // Тест 2: Тестируем нажатие на кнопку входа:
  testWidgets('Tap Login button', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.tap(find.text('Login'));

    await tester.pumpAndSettle();
    expect(find.text('Choose where to go'), findsOneWidget);
  });


  // Тест 3: Тестируем прокрутку списка товаров:
  testWidgets('Drag to scroll item list', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Go to Items List'));
    await tester.pumpAndSettle();

    final listFinder = find.byType(ListView);
    await tester.drag(listFinder, const Offset(0, -300));
    await tester.pump();

    expect(listFinder, findsOneWidget);
  });


  // Тест 4: Тестируем добавление нового товара:
  testWidgets('Add a new item', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Go to Items List'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Test Item');
    await tester.enterText(find.byType(TextField).at(1), 'Description');
    await tester.enterText(find.byType(TextField).at(2), '10.0');
    await tester.enterText(find.byType(TextField).at(3), '5.0');
    await tester.enterText(find.byType(TextField).at(4), 'http://image.url');

    await tester.tap(find.text('Add Item'));
    await tester.pumpAndSettle();

    expect(find.text('Test Item'), findsOneWidget);
  });


  // Тест 5: Тестируем редактирование существующего товара:
  testWidgets('Edit an item', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Go to Items List'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.edit).first);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Updated Item');
    await tester.tap(find.text('Edit Item'));
    await tester.pumpAndSettle();

    expect(find.text('Updated Item'), findsOneWidget);
  });

}
