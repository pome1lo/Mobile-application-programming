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

  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(FavoriteItemAdapter());

  await Hive.deleteBoxFromDisk('items');
  await Hive.deleteBoxFromDisk('users');
  await Hive.deleteBoxFromDisk('favorites');

  await Hive.openBox<Item>('items');
  await Hive.openBox<User>('users');
  await Hive.openBox<FavoriteItem>('favorites');

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
    itemBox.add(Item(name: 'Item 1', description: 'Description for Item 1', price: 111.0, imageUrl: 'assets/images/1.jpg'));
    itemBox.add(Item(name: 'Item 2', description: 'Description for Item 2', price: 222.0, imageUrl: 'assets/images/2.jpg'));
    itemBox.add(Item(name: 'Item 3', description: 'Description for Item 3', price: 333.0, imageUrl: 'assets/images/3.jpg'));
    itemBox.add(Item(name: 'Item 4', description: 'Description for Item 4', price: 444.0, imageUrl: 'assets/images/4.jpg'));
    itemBox.add(Item(name: 'Item 5', description: 'Description for Item 5', price: 555.0, imageUrl: 'assets/images/5.jpg'));
    itemBox.add(Item(name: 'Item 6', description: 'Description for Item 6', price: 666.0, imageUrl: 'assets/images/6.jpg'));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/itemDetail') {
          final item = settings.arguments as Item;
          return MaterialPageRoute(
            builder: (context) => ItemDetailPage(item: item),
          );
        }
        return null;
      },
      routes: {
        '/': (context) => UserSelectionPage(),
        '/itemList': (context) => ItemListPage(),
      },
    );
  }
}
