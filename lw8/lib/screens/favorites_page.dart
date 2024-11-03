import 'package:flutter/material.dart';
import '../models/favorite_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: ValueListenableBuilder<Box<FavoriteItem>>(
        valueListenable: Hive.box<FavoriteItem>('favorites').listenable(),
        builder: (context, box, _) {
          final favorites = box.values.toList();
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              return ListTile(
                title: Text(favorite.itemName),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Удаление элемента из избранного
                    box.deleteAt(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${favorite.itemName} удален из избранного')),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
