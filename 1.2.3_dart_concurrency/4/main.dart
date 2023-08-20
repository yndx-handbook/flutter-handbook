void main() {
  badAsyncJob();
  goodAsyncJob();
}

badAsyncJob() async {
  try {
    print('Start badAsyncJob');
    throwAsyncJob();
  } catch (e, stacktrace) {
    print('Caught badAsyncJob: $e');
  }
}

goodAsyncJob() async {
  try {
    print('Start goodAsyncJob');

    await throwAsyncJob();
  } catch (e, stacktrace) {
    print('Caught goodAsyncJob: $e');
  }
}

throwAsyncJob() async {
  print('Start throwAsyncJob');
  throw Exception('Hello, i am async error');
}
