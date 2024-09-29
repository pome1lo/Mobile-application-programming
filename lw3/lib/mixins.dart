mixin Scoring {
  int score = 0;

  void increaseScore() {
    score++;
    print('Score increased to $score');
  }
}

class Football with Scoring {
  String name;
  int players;

  Football(this.name, this.players);

  void play() {
    print('$name is being played with $players players.');
  }
}

void main() {
  Football football = Football('Football', 11);
  football.increaseScore();
}