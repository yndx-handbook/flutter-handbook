void main() {
  PrinterInterface printer = Printer('Hello, world!');

  printer.printValue();

  // Ошибка появляется, потому что PrinterInterface "не знает" про метод foo()
  printer.foo();

  Printer correctPrinter = Printer('Hello, correct!');
  correctPrinter.printValue();
  correctPrinter.foo();
}

abstract class PrinterInterface {
  void printValue();
}

abstract class FooInterface {
  void foo();
}

class Printer implements PrinterInterface, FooInterface {
  final String _valueToPrint;

  const Printer(this._valueToPrint);

  @override
  void printValue() {
    print('Printing: $_valueToPrint');
  }

  void foo() {
    print('Fooing');
  }
}
