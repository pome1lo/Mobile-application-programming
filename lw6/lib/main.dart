import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class Product {
  final String name;
  final String description;
  final double price;
  final double rating;
  final List<String> images;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.images,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: ProductListScreen(),
       home: BluetoothStatusScreen(),
      //home: BatteryStatusScreen(),
    );
  }
}



class ProductListScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'Product 1',
      description: 'Description of Product 1',
      price: 100.0,
      rating: 4.5,
      images: [
        'https://via.placeholder.com/150',
        'https://via.placeholder.com/150/0000FF',
        'https://via.placeholder.com/150/FF0000'
      ],
    ),
    Product(
      name: 'Product 2',
      description: 'Description of Product 2',
      price: 150.0,
      rating: 4.0,
      images: [
        'https://via.placeholder.com/150',
        'https://via.placeholder.com/150/00FF00',
        'https://via.placeholder.com/150/FFFF00'
      ],
    ),
    // Add more products here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Image.network(product.images[0], height: 100, fit: BoxFit.cover),
                  SizedBox(height: 8),
                  Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('\$${product.price.toStringAsFixed(2)}'),
                  SizedBox(height: 8),
                  Text('Rating: ${product.rating}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PageView для просмотра нескольких изображений товара
            Container(
              height: 200,
              child: PageView.builder(
                itemCount: product.images.length,
                itemBuilder: (context, index) {
                  return Image.network(product.images[index], fit: BoxFit.cover);
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Price: \$${product.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Rating: ${product.rating}',
              style: TextStyle(fontSize: 18),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select Color:'),
                DropdownButton<String>(
                  items: ['Red', 'Blue', 'Green']
                      .map((color) => DropdownMenuItem<String>(
                    child: Text(color),
                    value: color,
                  ))
                      .toList(),
                  onChanged: (value) {},
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quantity:'),
                DropdownButton<int>(
                  items: [1, 2, 3, 4, 5]
                      .map((qty) => DropdownMenuItem<int>(
                    child: Text(qty.toString()),
                    value: qty,
                  ))
                      .toList(),
                  onChanged: (value) {},
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Added to cart'),
                ));
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}


////


class BluetoothStatusScreen extends StatefulWidget {
  @override
  _BluetoothStatusScreenState createState() => _BluetoothStatusScreenState();
}

class _BluetoothStatusScreenState extends State<BluetoothStatusScreen> {
  // static const platform = MethodChannel('com.example/bluetooth');
  static const platform = MethodChannel('com.example/browser');
  String _bluetoothStatus = 'Unknown';
  String _url = 'http://www.google.com';

  @override
  void initState() {
    super.initState();
    _getBluetoothStatus();
  }

  Future<void> _getBluetoothStatus() async {
    String bluetoothStatus;
    try {
      final bool result = await platform.invokeMethod('getBluetoothStatus');
      bluetoothStatus = result ? 'Bluetooth is ON' : 'Bluetooth is OFF';
    } on PlatformException catch (e) {
      bluetoothStatus = "Failed to get Bluetooth status: '${e.message}'.";
    }

    setState(() {
      _bluetoothStatus = bluetoothStatus;
    });
  }

  Future<void> _launchBrowser(String url) async {
    try {
      await platform.invokeMethod('launchBrowser', {'url': url});
    } on PlatformException catch (e) {
      print("Failed to open browser: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Status'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Current Bluetooth Status:'),
            Text(
              '$_bluetoothStatus',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: _getBluetoothStatus,
              child: Text('Refresh Status'),
            ),
            ElevatedButton(
              onPressed: () => _launchBrowser(_url),
              child: Text('Open Flutter Website'),
            ),
          ],
        ),
      ),
    );
  }
}


////


class BatteryStatusScreen extends StatefulWidget {
  @override
  _BatteryStatusScreenState createState() => _BatteryStatusScreenState();
}

class _BatteryStatusScreenState extends State<BatteryStatusScreen> {
  static const platform = MethodChannel('com.example/battery');
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result%.';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Battery Level'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Battery Level: $_batteryLevel'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getBatteryLevel,
              child: Text('Get Battery Level'),
            ),
          ],
        ),
      ),
    );
  }
}