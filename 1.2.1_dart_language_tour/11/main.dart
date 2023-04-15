void main() {
  final value = 20;

  final concatenatedString = getConcatenatedString(value);
  final interpolatedString = getInterpolatedString(value);
  final stringBufferString = getStringBufferString(value);

  print(concatenatedString);
  print(interpolatedString);
  print(stringBufferString);
}

String getConcatenatedString(int value) {
  //Конкатенировать можно только строки
  return 'Hello! I am ' + value.toString() + ' years old';
}

String getInterpolatedString(int value) {
  return 'Hello! I am $value years old';
}

String getStringBufferString(int value) {
  final stringBuffer = StringBuffer();

  stringBuffer.write('Hello! I am ');
  // С StringBuffer toString() уже вызывать не нужно
  // write принимает значения типа Object?
  stringBuffer.write(value);
  stringBuffer.write(' years old');

  return stringBuffer.toString();
}
