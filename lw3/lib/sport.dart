abstract class Sport {
  void play();
}

abstract class TeamSport implements Sport {
  void teamSize();
}


class Football extends TeamSport {
  String name;
  int players;

  // Конструктор
  Football(this.name, this.players);

  // Именованный конструктор
  Football.withDefaultPlayers(this.name) : players = 11;

  // Getter и Setter
  int get playerCount => players;
  set playerCount(int count) => players = count;

  // Реализация методов интерфейса и абстрактного класса
  @override
  void play() {
    print('$name is being played with $players players.');
  }

  @override
  void teamSize() {
    print('A football team has $players players.');
  }

  // Статическое поле и функция
  static String sportType = 'Outdoor'; // На открытом воздухе
  static void showSportType() {
    print('Football is an $sportType sport.');
  }

  // Функции с различными параметрами
  void scoreGoal({required String playerName}) {
    print('$playerName scored a goal!');
  }

  void substitutePlayer([String? playerName]) {
    if (playerName != null) {
      print('$playerName is being substituted.');
    } else {
      print('A player is being substituted.');
    }
  }

  void performAction(Function action) {
    action();
  }

  void showTeam({String teamName = 'Unknown'}) {
    print('Team: $teamName');
  }
}
