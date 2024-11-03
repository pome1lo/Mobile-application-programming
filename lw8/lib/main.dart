import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lw4_5/models/favorite_item.dart';
import 'package:lw4_5/models/item.dart';
import 'package:lw4_5/models/user.dart';
import 'package:lw4_5/screens/item_detail_page.dart';
import 'package:lw4_5/screens/item_list_page.dart';
import 'package:lw4_5/screens/user_selection_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Регистрация адаптеров
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(FavoriteItemAdapter());

  // Удаление старых боксов, если это необходимо
  await Hive.deleteBoxFromDisk('items');
  await Hive.deleteBoxFromDisk('users');
  await Hive.deleteBoxFromDisk('favorites');

  // Открытие боксов
  await Hive.openBox<Item>('items');
  await Hive.openBox<User>('users');
  await Hive.openBox<FavoriteItem>('favorites');

  // Заполнение базы данных начальными данными (если нужно)
  await _initializeData();

  runApp(MyApp());
}

Future<void> _initializeData() async {
  final userBox = Hive.box<User>('users');
  if (userBox.isEmpty) {
    userBox.add(User(name: 'Admin', role: 'Administrator'));
    userBox.add(User(name: 'User 1', role: 'User'));
    userBox.add(User(name: 'User 2', role: 'User'));
  }

  final itemBox = Hive.box<Item>('items');
  if (itemBox.isEmpty) {
    itemBox.add(Item(name: 'Item 1', description: 'Description for Item 1', price: 111.0));
    itemBox.add(Item(name: 'Item 2', description: 'Description for Item 2', price: 222.0));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => UserSelectionPage(),
        '/itemList': (context) => ItemListPage(),
        '/itemDetail': (context) => ItemDetailPage(),
      },
    );
  }
}
