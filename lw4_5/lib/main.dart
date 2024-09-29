import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Item {
  final String name;
  final String description;
  final double price;
  final double rating;
  final String imageUrl; // Путь к изображению

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
  runApp(const MyApp());
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
      ),
      body: Column(
        children: [
          // Поле для поиска и кнопка настроек
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                // Серое поле для поиска с иконкой лупы
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
                // Кнопка настроек
                SizedBox(
                  width: 50,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Черный цвет кнопки
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Квадратная кнопка с небольшим радиусом углов
                      ),
                    ),
                    onPressed: () {
                      // Действие при нажатии на кнопку настроек
                      print('Settings pressed');
                    },
                    child: const Icon(
                      Icons.settings,
                      color: Colors.yellow, // Желтая иконка настроек
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
                crossAxisCount: 2, // 2 элемента в ряд
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.76, // Отношение сторон элемента (увеличивает высоту)
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
                    color: Colors.white, // Цвет карточки белый
                    elevation: 5,
                    child: SizedBox(
                      height: 300, // Фиксированная высота карточки
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Image.asset(
                                  item.imageUrl,
                                  height: 150, // Увеличенная высота изображения
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey, // Фон кнопки серый
                                    radius: 15,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        // Действие при нажатии на кнопку с сердечком
                                        print('Liked');
                                      },
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Colors.white, // Белое сердечко
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
                                // Черная круглая кнопка с желтым знаком "плюс"
                                CircleAvatar(
                                  backgroundColor: Colors.black, // Фон кнопки черный
                                  child: IconButton(
                                    onPressed: () {
                                      // Действие при нажатии на кнопку "плюс"
                                      print('Add to cart');
                                    },
                                    icon: const Icon(Icons.add, color: Colors.yellow), // Желтый знак "плюс"
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




class DetailPage extends StatefulWidget {
  final Item item;

  const DetailPage({super.key, required this.item});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _quantity = 1; // Количество товара в корзине

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Первая карточка с изображением и ценой
          Card(
            color: Colors.white,
            margin: const EdgeInsets.all(16.0),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        widget.item.imageUrl,
                        height: 380, // Увеличенная высота изображения
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey, // Фон кнопки серый
                          radius: 15,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              // Действие при нажатии на кнопку с сердечком
                              print('Liked');
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.white, // Белое сердечко
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          '\$${widget.item.price.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.yellow, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Вторая карточка с радиокнопками
          Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildColorRadio(Colors.red, 'Red'),
                  _buildColorRadio(Colors.green, 'Green'),
                  _buildColorRadio(Colors.blue, 'Blue'),
                  _buildColorRadio(Colors.yellow, 'Yellow'),
                  _buildColorRadio(Colors.orange, 'Orange'),
                ],
              ),
            ),
          ),

          // Третья карточка с описанием
          Card(
            color: Colors.white,
            margin: const EdgeInsets.all(16.0),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('⭐ (${widget.item.rating})'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(widget.item.description, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_quantity > 1) _quantity--;
                    });
                  },
                  icon: const Icon(Icons.remove, color: Colors.black),
                ),
                Text('$_quantity', style: const TextStyle(fontSize: 18)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                  icon: const Icon(Icons.add, color: Colors.black),
                ),
              ],
            ),
            Text(
              'Total: \$${(widget.item.price * _quantity).toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {
                // Действие при нажатии на кнопку "Добавить в корзину"
                print('Added to cart');
              },
              child: const Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.yellow, backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorRadio(Color color, String label) {
    return Row(
      children: [
        Radio<Color>(
          value: color,
          groupValue: color, // Здесь можно добавить логику для выбора текущего цвета
          onChanged: (Color? value) {
            // Логика изменения цвета
          },
          activeColor: color,
        ),

      ],
    );
  }
}