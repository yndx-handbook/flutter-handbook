void main() {
  final classObject = MyClass();
  classObject._privateField;
  classObject._privateFunction();

  SecondClass().printPrivateFunction();
}

class MyClass {
  final _privateField = "Hi, im private";

  void _privateFunction() {
    print(_privateField);
  }
}

class SecondClass {
  void printPrivateFunction() {
    MyClass()._privateFunction();
  }
}
