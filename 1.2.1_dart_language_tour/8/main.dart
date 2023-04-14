void main() {
  const constList = const List<int>();
  final finalList = List<int>();

  constList.add(2);
  finalList.add(3);

  print(constList);
  print(finalList);
}
