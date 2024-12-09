import 'dart:async';
import 'package:flutter/material.dart';

// Класс модели Item
class Item {
  final String name;
  final String imageUrl;
  final double price;
  final double rating;

  Item({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
  });
}

// Да, наш код соответствует представленной схеме. Вот как это отражено в коде:
//
// BLoC Component
// В коде мы создали BLoC-компонент (ItemsBloc), который управляет бизнес-логикой и потоками данных. Он содержит StreamController для отслеживания списка элементов и их обновления.
//
// Sink и Stream
// В ItemsBloc есть sink и stream через StreamController. Sink принимает данные (например, события изменения списка), а Stream передаёт эти данные виджетам.
//
// StreamBuilder
// В основном виджете (например, в HomePage) используется StreamBuilder, который подписывается на поток из BLoC и обновляет пользовательский интерфейс при изменении данных.
//
// BLoC Provider
// Для передачи экземпляра ItemsBloc в дерево виджетов используется Provider, который выступает аналогом BlocProvider в схеме. Он предоставляет доступ к BLoC для виджетов, находящихся ниже по иерархии.
//
// Таким образом, код следует данной схеме: BLoC компоненты взаимодействуют с виджетами через StreamBuilder, а провайдер отвечает за передачу экземпляра BLoC.

// Пример данных
final List<Item> items = [
  Item(name: 'Product 1', imageUrl: 'assets/images/1.jpg', price: 10.0, rating: 4.5),
  Item(name: 'Product 2', imageUrl: 'assets/images/2.jpg', price: 15.0, rating: 4.0),
  Item(name: 'Product 3', imageUrl: 'assets/images/3.jpg', price: 10.0, rating: 4.5),
  Item(name: 'Product 4', imageUrl: 'assets/images/4.jpg', price: 15.0, rating: 4.0),
  Item(name: 'Product 5', imageUrl: 'assets/images/5.jpg', price: 10.0, rating: 4.5),
  Item(name: 'Product 6', imageUrl: 'assets/images/6.jpg', price: 15.0, rating: 4.0),
  Item(name: 'Product 7', imageUrl: 'assets/images/7.jpg', price: 10.0, rating: 4.5),
  Item(name: 'Product 8', imageUrl: 'assets/images/8.jpg', price: 15.0, rating: 4.0),
  Item(name: 'Product 9', imageUrl: 'assets/images/9.jpg', price: 10.0, rating: 4.5),
  Item(name: 'Product 10', imageUrl: 'assets/images/10.jpg', price: 15.0, rating: 4.0),
  // Добавьте остальные товары
];

// Класс BLoC для управления состоянием
class ItemsBloc {
  final _itemsController = StreamController<List<Item>>();

  // Stream для передачи данных в виджет
  Stream<List<Item>> get itemsStream => _itemsController.stream;

  // Локальный список товаров
  List<Item> _items = items;

  // Метод фильтрации товаров по названию
  void filterItems(String query) {
    final filteredItems = _items
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    _itemsController.sink.add(filteredItems);
  }

  // Метод закрытия StreamController
  void dispose() {
    _itemsController.close();
  }
}
// Виджет ItemsBlocProvider для предоставления BLoC в дереве виджетов
class ItemsBlocProvider extends InheritedWidget {
  final ItemsBloc bloc;

  ItemsBlocProvider({Key? key, required Widget child})
      : bloc = ItemsBloc(),
        super(key: key, child: child);

  static ItemsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ItemsBlocProvider>()!).bloc;
  }

  @override
  bool updateShouldNotify(_) => true;
}

// Основной класс приложения
void main() {
  runApp(
    ItemsBlocProvider(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLoC Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

// Главная страница приложения с поиском и списком товаров
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = ItemsBlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Поиск товаров'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: bloc.filterItems,
              decoration: InputDecoration(
                hintText: 'Поиск...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Item>>(
              stream: bloc.itemsStream,
              initialData: items,
              builder: (context, snapshot) {
                final items = snapshot.data ?? [];

                return GridView.builder(
                  padding: const EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.76,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(item: item),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Column(
                          children: [
                            Image.asset(
                              item.imageUrl,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('⭐ (${item.rating})'),
                            Text('\$${item.price.toStringAsFixed(2)}'),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Страница деталей товара
class DetailPage extends StatelessWidget {
  final Item item;

  const DetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(item.imageUrl, height: 250),
            const SizedBox(height: 10),
            Text(item.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Цена: \$${item.price.toStringAsFixed(2)}'),
            Text('Рейтинг: ⭐ (${item.rating})'),
          ],
        ),
      ),
    );
  }
}
