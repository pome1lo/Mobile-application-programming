import 'dart:convert';

class Football {
  String name;
  int players;

  Football(this.name, this.players);

  Map<String, dynamic> toJson() => {
    'name': name,
    'players': players,
  };

  factory Football.fromJson(Map<String, dynamic> json) {
    return Football(
      json['name'],
      json['players'],
    );
  }
}

void main() {
  Football football = Football('Football', 11);
  String jsonString = jsonEncode(football);
  print('Serialized: $jsonString');

  Football deserializedFootball = Football.fromJson(jsonDecode(jsonString));
  print('Deserialized: ${deserializedFootball.name}, ${deserializedFootball.players}');
}
