import 'package:flutter/material.dart';
import 'package:lw4_5/models/favorite_item.dart';
import 'package:lw4_5/models/user.dart';
import 'package:lw4_5/screens/admin_product_page.dart';
import '../models/item.dart';
import 'favorites_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ItemListPage extends StatelessWidget {
  void _navigateToAdminPage(BuildContext context, String userRole) {
    if (userRole == 'Administrator') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminProductPage()),
      );
    } else {
      // Покажите сообщение, что доступ запрещен
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Access Denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Проверка наличия открытого бокса
    if (!Hive.isBoxOpen('users') || !Hive.isBoxOpen('items')) {
      return Center(child: CircularProgressIndicator()); // Или сообщение об ошибке
    }

    // Получение выбранного пользователя из аргументов
    final String userRole = ModalRoute.of(context)?.settings.arguments as String? ?? 'User';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<Item>>(
        valueListenable: Hive.box<Item>('items').listenable(),
        builder: (context, box, _) {
          final items = box.values.toList();
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item.name),
                onTap: () {
                  // Навигация к детальной странице товара
                  Navigator.pushNamed(context, '/itemDetail', arguments: item);
                },
                trailing: IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    final favoritesBox = Hive.box<FavoriteItem>('favorites');
                    favoritesBox.add(FavoriteItem(itemName: item.name));
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAdminPage(context, userRole),
        child: Icon(Icons.admin_panel_settings),
        tooltip: 'Admin Panel',
      ),
    );
  }
}
