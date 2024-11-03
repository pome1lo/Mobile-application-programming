import '../models/user.dart';
import '../models/item.dart';
import '../models/favorite_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(ItemAdapter());
    Hive.registerAdapter(FavoriteItemAdapter());
    await Hive.openBox<User>('users');
    await Hive.openBox<Item>('items');
    await Hive.openBox<FavoriteItem>('favorites');
  }
}
