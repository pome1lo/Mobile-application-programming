import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 1)
class Item {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String imageUrl;

  Item({required this.name, required this.description, required this.price, required this.imageUrl});
}
