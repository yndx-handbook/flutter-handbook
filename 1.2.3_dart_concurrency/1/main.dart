void main() {
  Future(() => throw Exception())
      .then(
        (_) => print('Print after future'),
        onError: (error, stacktrace) => print('Then: $error'),
      )
      .catchError((error, stacktrace) => print('catchError: $error'));
}
