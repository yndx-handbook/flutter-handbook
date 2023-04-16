void main() {
  const printer = const Printer('some String value');
}

class Printer {
  String valueToPrint;

  Printer(this.valueToPrint);

  void printValue() {
    print('Printing: $valueToPrint');
  }
}
