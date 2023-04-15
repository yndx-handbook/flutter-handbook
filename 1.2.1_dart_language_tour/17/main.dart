// Функции помеченные sync* всегда возвращают Iterable
Iterable<int> generateList(int length) sync* {
  int counter = 0;
  while (counter < length) {
    // Функция "запомнит" это место и продолжит выполнение отсюда при последующем вызове
    yield counter++;
  }
}

void main() {
  final myList = <int>[];

  for (final value in generateList(10)) {
    myList.add(value);
  }

  print(myList);
}
