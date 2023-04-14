void main() {
  var helloString = 'Hello, world!';

  print(helloString);

  //Код ниже выбросит compile time исключение, потому что на строке 2 для переменной был вычислен тип String
  helloString = 4;
  print(helloString);
}
