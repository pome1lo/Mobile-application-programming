import 'package:hive/hive.dart';

part 'favorite_item.g.dart';

@HiveType(typeId: 2)
class FavoriteItem {
  @HiveField(0)
  final String itemName;

  FavoriteItem({required this.itemName});
}
