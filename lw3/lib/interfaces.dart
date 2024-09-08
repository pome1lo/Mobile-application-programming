class Player implements Comparable<Player> {
  String name;
  int skillLevel;

  Player(this.name, this.skillLevel);

  @override
  int compareTo(Player other) {
    return skillLevel.compareTo(other.skillLevel);
  }
}

class Team implements Iterable<Player> {
  List<Player> players;

  Team(this.players);

  @override
  Iterator<Player> get iterator => players.iterator;





  @override
  bool any(bool Function(Player element) test) {
    // TODO: implement any
    throw UnimplementedError();
  }

  @override
  Iterable<R> cast<R>() {
    // TODO: implement cast
    throw UnimplementedError();
  }

  @override
  bool contains(Object? element) {
    // TODO: implement contains
    throw UnimplementedError();
  }

  @override
  Player elementAt(int index) {
    // TODO: implement elementAt
    throw UnimplementedError();
  }

  @override
  bool every(bool Function(Player element) test) {
    // TODO: implement every
    throw UnimplementedError();
  }

  @override
  Iterable<T> expand<T>(Iterable<T> Function(Player element) toElements) {
    // TODO: implement expand
    throw UnimplementedError();
  }

  @override
  // TODO: implement first
  Player get first => throw UnimplementedError();

  @override
  Player firstWhere(bool Function(Player element) test, {Player Function()? orElse}) {
    // TODO: implement firstWhere
    throw UnimplementedError();
  }

  @override
  T fold<T>(T initialValue, T Function(T previousValue, Player element) combine) {
    // TODO: implement fold
    throw UnimplementedError();
  }

  @override
  Iterable<Player> followedBy(Iterable<Player> other) {
    // TODO: implement followedBy
    throw UnimplementedError();
  }

  @override
  void forEach(void Function(Player element) action) {
    // TODO: implement forEach
  }

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  // TODO: implement isNotEmpty
  bool get isNotEmpty => throw UnimplementedError();

  @override
  String join([String separator = ""]) {
    // TODO: implement join
    throw UnimplementedError();
  }

  @override
  // TODO: implement last
  Player get last => throw UnimplementedError();

  @override
  Player lastWhere(bool Function(Player element) test, {Player Function()? orElse}) {
    // TODO: implement lastWhere
    throw UnimplementedError();
  }

  @override
  // TODO: implement length
  int get length => throw UnimplementedError();

  @override
  Iterable<T> map<T>(T Function(Player e) toElement) {
    // TODO: implement map
    throw UnimplementedError();
  }

  @override
  Player reduce(Player Function(Player value, Player element) combine) {
    // TODO: implement reduce
    throw UnimplementedError();
  }

  @override
  // TODO: implement single
  Player get single => throw UnimplementedError();

  @override
  Player singleWhere(bool Function(Player element) test, {Player Function()? orElse}) {
    // TODO: implement singleWhere
    throw UnimplementedError();
  }

  @override
  Iterable<Player> skip(int count) {
    // TODO: implement skip
    throw UnimplementedError();
  }

  @override
  Iterable<Player> skipWhile(bool Function(Player value) test) {
    // TODO: implement skipWhile
    throw UnimplementedError();
  }

  @override
  Iterable<Player> take(int count) {
    // TODO: implement take
    throw UnimplementedError();
  }

  @override
  Iterable<Player> takeWhile(bool Function(Player value) test) {
    // TODO: implement takeWhile
    throw UnimplementedError();
  }

  @override
  List<Player> toList({bool growable = true}) {
    // TODO: implement toList
    throw UnimplementedError();
  }

  @override
  Set<Player> toSet() {
    // TODO: implement toSet
    throw UnimplementedError();
  }

  @override
  Iterable<Player> where(bool Function(Player element) test) {
    // TODO: implement where
    throw UnimplementedError();
  }

  @override
  Iterable<T> whereType<T>() {
    // TODO: implement whereType
    throw UnimplementedError();
  }
}
