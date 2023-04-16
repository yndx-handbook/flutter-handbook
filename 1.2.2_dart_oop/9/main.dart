class P {
  String getMessage() => 'P';
}

mixin A {
  String getMessage() => 'A';
}

mixin B {
  String getMessage() => 'B';
}

class AB extends P with A, B {}

class BA extends P with B, A {}

void main() {
  String message = '';

  AB ab = AB();

  message += ab.getMessage();

  BA ba = BA();

  message += ba.getMessage();

  print(message);
}
