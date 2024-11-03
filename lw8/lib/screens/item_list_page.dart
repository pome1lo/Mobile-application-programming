import 'package:flutter/material.dart';
import 'package:lw4_5/models/favorite_item.dart';
import 'package:lw4_5/screens/admin_product_page.dart';
import '../models/item.dart';
import 'favorites_page.dart';
import 'item_detail_page.dart'; // Импортируем экран описания
import 'package:hive_flutter/hive_flutter.dart';

class ItemListPage extends StatelessWidget {
  void _navigateToAdminPage(BuildContext context, String userRole) {
    if (userRole == 'Administrator') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminProductPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Access Denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!Hive.isBoxOpen('users') || !Hive.isBoxOpen('items')) {
      return Center(child: CircularProgressIndicator());
    }

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
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.75,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () {
                  // Переход на экран описания
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetailPage(item: item),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.asset(
                            item.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.add_shopping_cart),
                                  onPressed: () {
                                    // Логика добавления в корзину
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  onPressed: () {
                                    final favoritesBox = Hive.box<FavoriteItem>('favorites');
                                    favoritesBox.add(FavoriteItem(itemName: item.name));
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
