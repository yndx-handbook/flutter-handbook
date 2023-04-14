void main() {
  // Чтобы избежать такого неоднозначного поведения, достаточно явно указать тип переменной
  // String? variable;
  var variable;

  print('Not initialized variable:');
  print(variable.runtimeType);
  print(variable);

  //Теперь присвоим целочисленное значение variable
  variable = 1;
  print('Integer variable:');
  print(variable.runtimeType);
  print(variable);

  //И нам так же не мешает этой же перменной присвоить Строку
  variable = '2';
  print('String variable:');
  print(variable.runtimeType);
  print(variable);
}
