void main() {
  print('Before operation');
  getAsyncJobValue().then((value) => print("Go async value: $value"));
  print('After operation');
}

Future<int> getAsyncJobValue() async {
  print('Sync inside async');
  await Future(()=> print('Awaited async job'));
  return Future.value(5);
}
