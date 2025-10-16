import 'page_config.dart';

/// Наша конфигурация, обобщенная под использование [PageConfiguration].
class AppPagesConfig extends RouterPagesStack<PageConfiguration> {
  AppPagesConfig(super.stack);
}

/// Реализация стека на основе [List], которая и будет нашей конфигурацией
/// навигации в приложении. Для своего приложения вы можете создать свое
/// состояние.
class RouterPagesStack<T> {
  final List<T> _stack;

  RouterPagesStack(this._stack);

  List<T> get pages => _stack;

  int get length => _stack.length;

  T get last => _stack.last;

  void pop() {
    _stack.removeLast();
  }

  void push(T value) {
    _stack.add(value);
  }

  void pushAllWithReplacement(List<T> values) {
    _stack
      ..clear()
      ..addAll(values);
  }
}
