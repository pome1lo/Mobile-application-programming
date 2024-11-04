
import 'package:lab7/data/programmer.dart';

class JavaDeveloper extends Programmer {
  String specialty;

  JavaDeveloper({
    int? id,
    required String name,
    this.specialty = 'Java',
  }) : super(name, id: id);

  @override
  void work() {
    print('$name работает как Java Developer');
  }
  factory JavaDeveloper.fromJson(Map<String, dynamic> json) {
    return JavaDeveloper(
      id: json['id'],
      name: json['name'],
      specialty: json['specialty'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
    };
  }
}