void main() {
  // Пусть у нас будет List, с nullable элементами
  final myList = <MyClass?>[MyClass()];

  // Получаем ошибку на этапе компиляции
  final value = myList.first.foo();
}

class MyClass {
  int foo() {
    return 5;
  }
}
