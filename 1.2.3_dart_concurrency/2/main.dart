void main() {
  print('Before operation');
  foo();
  print('After operation');
}

void foo() async {
  print('async');
}
