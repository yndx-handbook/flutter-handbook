void main() {
  // Пусть у нас будет переменная, которая может содержать null
  MyClass? myClass;

  // Получаем ошибку на этапе компиляции
  final value = myClass.foo();
}

class MyClass {
  int foo() {
    return 5;
  }
}
