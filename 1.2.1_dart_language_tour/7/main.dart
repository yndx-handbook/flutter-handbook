void main() {
  const a = 5;
  A()._foo();
  a = 5;

  print('Integer variable: $a');

  a = 6;
  print('Integer variable 2: $a');

  a = 'Some string';
  print('String variable: $a');
}
