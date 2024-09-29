import 'dart:async' show Future;

Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2)); // Задержка 2 секунды
  return 'Data fetched';
}

void main() async {
  print('Fetching data...');


  fetchData().then((data) {
    print(data);
  }).catchError((error) {
    print('An error occurred: $error');
  }).whenComplete(() {
    print('Fetch data operation completed');
  });

  try {
    String data = await fetchData();
    print(data);
  } catch (error) {
    print('An error occurred: $error');
  } finally {
    print('Fetch data operation completed');
  }
}
