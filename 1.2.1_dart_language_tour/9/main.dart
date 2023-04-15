void main() {
  final condition = true;

  final map = {
    if (condition) 'foo': 2 else 'bar': 3,
    'baz': 4,
  };

  final Set<int> mySet = {1, if (condition) 3 else 1, 2};

  final list = [1, if (condition) 2 else 3, 4];

  print(list);
  print(mySet);
  print(map);
}
