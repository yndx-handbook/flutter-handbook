void main() {
  final regExp = RegExp('world');
  final myString = 'Hello, world!';
  final hasWorld = regExp.hasMatch(myString);
  print(hasWorld);
}
