import 'package:flutter/material.dart';
import 'package:lw4_5/models/item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdminProductPage extends StatelessWidget {
  final Box<Item> productBox = Hive.box<Item>('items');

  void _addProduct(BuildContext context) {
    _showProductDialog(context, null);
  }

  void _editProduct(BuildContext context, Item product, int index) {
    _showProductDialog(context, product, index);
  }

  void _showProductDialog(BuildContext context, Item? product, [int? index]) {
    String name = product?.name ?? '';
    String description = product?.description ?? '';
    double price = product?.price ?? 0.0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(product == null ? 'Add Product' : 'Edit Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => name = value,
                decoration: InputDecoration(labelText: 'Product Name'),
                controller: TextEditingController(text: name),
              ),
              TextField(
                onChanged: (value) => description = value,
                decoration: InputDecoration(labelText: 'Description'),
                controller: TextEditingController(text: description),
              ),
              TextField(
                onChanged: (value) => price = double.tryParse(value) ?? 0.0,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: price.toString()),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (product == null) {
                  // Добавление нового товара
                  final newProduct = Item(name: name, description: description, price: price);
                  productBox.add(newProduct);
                } else {
                  // Обновление существующего товара
                  final updatedProduct = Item(name: name, description: description, price: price);
                  productBox.putAt(index!, updatedProduct); // Обновление товара
                }
                Navigator.of(context).pop();
              },
              child: Text(product == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(int index) {
    productBox.deleteAt(index); // Удаление товара по индексу
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addProduct(context),
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<Item>>(
        valueListenable: productBox.listenable(),
        builder: (context, box, _) {
          final products = box.values.toList();
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text('\$${product.price}'),
                onTap: () => _editProduct(context, product, index), // Редактирование товара
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteProduct(index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
