// models/athlete.dart

// Интерфейс для действий, которые может выполнять спортсмен
abstract class AthleteActions {
  void performAction();
}

// Абстрактный класс SportPerson
abstract class SportPerson {
  String name;
  String sport;

  SportPerson({required this.name, required this.sport});

  // Абстрактный метод, который нужно перегрузить
  void introduceYourself();
}

// Класс Athlete, который реализует интерфейс и перегружает методы абстрактного класса
class Athlete extends SportPerson implements AthleteActions {
  int? id; // ID может быть null для новых спортсменов
  int score;

  Athlete({this.id, required String name, required String sport, this.score = 0})
      : super(name: name, sport: sport);

  // Именованный конструктор для создания спортсмена с результатом
  Athlete.withScore(String name, String sport, int score)
      : this.score = score,
        super(name: name, sport: sport);

  // Getter и Setter
  int get getScore => score;
  set setScore(int score) => this.score = score;

  // Переопределение метода абстрактного класса
  @override
  void introduceYourself() {
    print("Hello, my name is $name and I play $sport.");
  }

  // Реализация метода интерфейса
  @override
  void performAction() {
    print("$name is performing an action in $sport.");
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'sport': sport,
      'score': score,
    };

    if (id != null) {
      map['id'] = id; // Добавляем id только если оно не null
    }

    return map;
  }

  // Создание объекта из Map
  factory Athlete.fromMap(Map<String, dynamic> map) {
    return Athlete(
      id: map['id'],
      name: map['name'],
      sport: map['sport'],
      score: map['score'],
    );
  }
}
