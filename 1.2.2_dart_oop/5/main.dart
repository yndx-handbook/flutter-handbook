void main() {
  const printer = const Printer('some String value');
  printer.printValue();
}

class Printer {
  final String _valueToPrint;

  const Printer(this._valueToPrint);

  void printValue() {
    print('Printing: $_valueToPrint');
  }
}
