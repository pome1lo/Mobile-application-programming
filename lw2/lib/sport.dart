abstract class Sport {
  void play();
}

abstract class TeamSport implements Sport {
  void teamSize();
}


class Football extends TeamSport {
  String name;
  int players;

  Football(this.name, this.players);

  Football.withDefaultPlayers(this.name) : players = 11;


  // get set
  int get playerCount => players;
  set playerCount(int count) => players = count;


  @override
  void play() {
    print('$name is being played with $players players.');
  }

  @override
  void teamSize() {
    print('A football team has $players players.');
  }


  static String sportType = 'Outdoor'; // На открытом воздухе
  static void showSportType() {
    print('Football is an $sportType sport.');
  }


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
