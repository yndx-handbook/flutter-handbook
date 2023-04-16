void main() {
  const printer = Printer('Hello, World!');
}

class Printer {
  final String _valueToPrint;

  Printer(this._valueToPrint);

  void printValue() {
    print('Printing: $_valueToPrint');
  }
}
