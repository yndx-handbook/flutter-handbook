void main() {
  // Предпочтительно
  final singleQuotedString = 'Hello, world!';
  // В основном нужен, если в строке могут быть одинарные кавычки.
  // В остальном, полная копия предыдущего
  final doubleQuotedString = "Hello, world! I'm 30!";
  // Сохраняет форматирование со всеми терминаторами
  final trippleQuotedString = '''
  Не кури, не влюбляйся, не пей вина
  И на лбу себе высеки:
  Жизнь тебе для того дана,
  Что бы ты её отдал физике!
  ''';
  // Игнорирует любые спецсимволы
  final rawString = r'Hello, world! I like dollar$$$$';

  print(singleQuotedString);
  print(doubleQuotedString);
  print(trippleQuotedString);
  print(rawString);
}
