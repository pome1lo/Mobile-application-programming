import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserSelectionPage extends StatefulWidget {
  @override
  _UserSelectionPageState createState() => _UserSelectionPageState();
}

class _UserSelectionPageState extends State<UserSelectionPage> {
  User? selectedUser;

  @override
  void initState() {
    super.initState();
    // По умолчанию selectedUser равен null, чтобы не устанавливать пользователя по умолчанию
    // Выбор пользователя будет происходить на экране
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select User')),
      body: ValueListenableBuilder<Box<User>>(
        valueListenable: Hive.box<User>('users').listenable(),
        builder: (context, box, _) {
          final users = box.values.toList();
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.role),
                leading: Radio<User>(
                  value: user,
                  groupValue: selectedUser,
                  onChanged: (User? value) {
                    setState(() {
                      print(value?.name);
                      selectedUser = value; // Обновление выбранного пользователя
                    });
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          // Проверьте, выбран ли пользователь перед переходом
          if (selectedUser != null) {
            // Здесь можно сделать переход к следующему экрану
            Navigator.pushNamed(context, '/itemList', arguments: selectedUser!.role);
          } else {
            // Вывод сообщения, если пользователь не выбран
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please select a user')),
            );
          }
        },
        child: const Text('Confirm Selection'),
      ),
    );
  }
}
