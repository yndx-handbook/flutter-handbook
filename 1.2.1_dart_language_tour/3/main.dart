void main() {
  dynamic helloString = 'Hello,world!';
  print(helloString);

  // Ошибки теперь не будет
  helloString = 4;
  print(helloString);

  //А теперь запишем в переменную строчку и попробуем использовать с ней математическую операцию
  helloString = 'I am string';
  print(helloString / 4);
}
