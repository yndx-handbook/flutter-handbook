void main() {
  final myObject = MyClass('String value');

  myObject.foo();
  myObject.bar();
  myObject.baz();
  myObject.myPrint();
}

abstract class MyAbstractClass {
  final String someValue;

  MyAbstractClass(this.someValue);

  void foo() {
    print('MyAbstractClass foo: $someValue');
  }

  void bar();

  void baz() {
    print('MyAbstractClass baz: $someValue');
  }
}

class MyClass extends MyAbstractClass {
  MyClass(super.someValue);
  // Или MyClass(String someValue):super(someValue); - это эквивалентные записи

  @override
  void bar() {
    print('MyClass bar: $someValue');
  }

  @override
  void baz() {
    print('MyClass baz: $someValue');
  }

  void myPrint() {
    print('My class print: $someValue');
  }
}
