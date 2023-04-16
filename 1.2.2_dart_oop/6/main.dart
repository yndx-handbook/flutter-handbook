void main() {
  Printer printer = Printer();
  Printer taggedPrinter = TaggedPrinter('MyTag');

  printer.print('some value');
  taggedPrinter.print('some value');
}

class Printer {
  void print(String value) {
    print('Printed: $value');
  }
}

class TaggedPrinter implements Printer {
  final String _tag;

  const TaggedPrinter(this._tag);

  @override
  void print(String value) {
    print('$_tag: $value');
  }
}
