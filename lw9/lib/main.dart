import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges; // Используем алиас для Badge

class CartItem {
  final Item item;
  int quantity;

  CartItem({required this.item, this.quantity = 1});
}

class Cart with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(Item item, int quantity) {
    final existingItemIndex = _items.indexWhere((cartItem) => cartItem.item.name == item.name);
    if (existingItemIndex >= 0) {
      _items[existingItemIndex].quantity += quantity; // Увеличиваем количество
    } else {
      _items.add(CartItem(item: item, quantity: quantity)); // Добавляем новый элемент с количеством
    }
    notifyListeners();
  }

  void removeItem(Item item) {
    _items.removeWhere((cartItem) => cartItem.item.name == item.name);
    notifyListeners();
  }

  double get totalAmount {
    return _items.fold(0.0, (sum, cartItem) => sum + (cartItem.item.price * cartItem.quantity));
  }
}

class Item {
  final String name;
  final String description;
  final double price;
  final double rating;
  final String imageUrl;

  Item({
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });
}

// Данные в формате JSON с путями к изображениям
List<Item> items = [
  Item(
    name: 'Silent Horizon',
    description: 'A beautiful and tranquil landscape that stretches across the horizon, offering a peaceful and relaxing view. The gentle breeze rustles through the trees, providing a sense of serenity and calmness.',
    price: 29.99,
    rating: 4.5,
    imageUrl: 'assets/images/1.jpg',
  ),
  Item(
    name: 'Golden Sunrise',
    description: 'As the sun rises over the horizon, it bathes the world in a golden glow, casting long shadows and highlighting the beauty of the natural world. It\'s a moment of pure magic that signals the start of a new day.',
    price: 19.99,
    rating: 3.8,
    imageUrl: 'assets/images/2.jpg',
  ),
  Item(
    name: 'Frozen Peak',
    description: 'A towering mountain peak, covered in snow and ice, rises majestically into the sky. The crisp, cold air and the vast, open landscape create a sense of awe and wonder, as nature reveals its power and beauty.',
    price: 35.00,
    rating: 4.8,
    imageUrl: 'assets/images/10.jpg',
  ),
  Item(
    name: 'Crimson Edge',
    description: 'A striking and bold artwork that captures the raw energy and emotion of a crimson sunset. The vivid colors and dynamic composition create a sense of movement and intensity that draws the viewer in.',
    price: 34.50,
    rating: 4.7,
    imageUrl: 'assets/images/3.jpg',
  ),
  Item(
    name: 'Azure Dreams',
    description: 'A dreamlike vision of a clear blue sky, reflected in the still waters of a tranquil lake. The soft hues and gentle ripples create a peaceful and calming atmosphere that soothes the soul.',
    price: 24.99,
    rating: 4.2,
    imageUrl: 'assets/images/4.jpg',
  ),
  Item(
    name: 'Midnight Whisper',
    description: 'In the quiet of the night, the stars twinkle overhead, whispering secrets to those who are still and listen. The cool night air and the silence of the world create a moment of introspection and wonder.',
    price: 39.00,
    rating: 4.9,
    imageUrl: 'assets/images/5.jpg',
  ),
  Item(
    name: 'Autumn Leaves',
    description: 'As the leaves turn from green to vibrant shades of red, orange, and yellow, the world is transformed into a tapestry of color. The crisp air and the scent of fallen leaves evoke a sense of nostalgia and warmth.',
    price: 27.99,
    rating: 4.6,
    imageUrl: 'assets/images/6.jpg',
  ),
  Item(
    name: 'Ocean Breeze',
    description: 'The salty air and the sound of crashing waves create a sensory experience that transports you to the shores of the ocean. The rhythmic ebb and flow of the tide is a reminder of the vastness and power of nature.',
    price: 22.99,
    rating: 4.3,
    imageUrl: 'assets/images/7.jpg',
  ),
  Item(
    name: 'Whispering Pines',
    description: 'Tall pine trees sway gently in the breeze, their needles creating a soft, rustling sound. The earthy scent of pine fills the air, offering a sense of grounding and connection to the natural world.',
    price: 25.50,
    rating: 4.4,
    imageUrl: 'assets/images/8.jpg',
  ),
  Item(
    name: 'Desert Mirage',
    description: 'In the heat of the desert, the distant horizon shimmers with a mirage, creating an otherworldly effect. The dry, cracked earth stretches out as far as the eye can see, offering a stark beauty in its desolation.',
    price: 31.99,
    rating: 4.7,
    imageUrl: 'assets/images/9.jpg',
  ),

];

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        actions: [
          Consumer<Cart>(
            builder: (context, cart, child) {
              return IconButton(
                icon: badges.Badge(
                  badgeContent: Text(cart.items.length.toString(), style: TextStyle(color: Colors.white)),
                  child: const Icon(Icons.shopping_cart),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()), // Переход на экран корзины
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Поле для поиска и кнопка настроек
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'IKEA company',
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
                const SizedBox(width: 10),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      print('Settings pressed');
                    },
                    child: const Icon(
                      Icons.settings,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Строка с количеством результатов
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
              children: const [
                Text('Found 10 results', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          // Сетка с элементами
          Expanded(
            child: GridView.builder(
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
                    child: SizedBox(
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Image.asset(
                                  item.imageUrl,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 15,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        print('Liked');
                                      },
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text('⭐ (${item.rating})'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('IKEA company'),
                                    Text('\$${item.price.toStringAsFixed(2)}'),
                                  ],
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: IconButton(
                                    onPressed: () {
                                      // Действие при нажатии на кнопку "плюс"
                                      print('Add to cart');
                                    },
                                    icon: const Icon(Icons.add, color: Colors.yellow),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Item item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    int _quantity = 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Изображение товара
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              item.imageUrl,
              height: 200, // Высота изображения
              fit: BoxFit.cover,
            ),
          ),
          // Информация о товаре
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              item.description,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Цена: \$${item.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Рейтинг: ⭐ (${item.rating})',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const Divider(), // Разделитель между контентом и кнопками
          // Поля для изменения количества и кнопка добавления в корзину
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (_quantity > 1) _quantity--; // Уменьшаем количество
                      },
                      icon: const Icon(Icons.remove),
                    ),
                    Text('$_quantity'),
                    IconButton(
                      onPressed: () {
                        _quantity++; // Увеличиваем количество
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    cart.addItem(item, _quantity); // Добавляем элемент в корзину с количеством
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item.name} добавлен в корзину')),
                    );
                  },
                  child: const Text('Добавить в корзину'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: cart.items.isEmpty
          ? Center(
        child: Text('Ваша корзина пуста!'),
      )
          : ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          final cartItem = cart.items[index];
          return ListTile(
            title: Text(cartItem.item.name),
            subtitle: Text('Количество: ${cartItem.quantity}'),
            trailing: Text('\$${(cartItem.item.price * cartItem.quantity).toStringAsFixed(2)}'),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Итого: \$${cart.totalAmount.toStringAsFixed(2)}'),
              ElevatedButton(
                onPressed: () {
                  // Логика для оформления заказа
                },
                child: const Text('Оформить заказ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
