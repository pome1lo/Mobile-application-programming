Future<void> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  print('Data fetched');
}

Future<void> main() async {
  await fetchData();
}