import 'package:flutter/widgets.dart';

import '../config/page_config.dart';
import '../config/pages_config.dart';

/// Абстракция над менеджером для хранения конфигурации навигации
/// [AppPagesConfig] и управления ею. Интерфейс имплементирует [Listenable]
/// для возможности подписки на состояние.
///
/// Зададим только 3 метода, необходимых в данном примере. При необходимости
/// можно дополнять данный интерфейс другими методами, такими как
/// pushReplacement, popUntil и т.д.
abstract class RouterPagesManager implements Listenable {
  /// Текущие страницы стека навигации.
  List<PageConfiguration> get pages;

  /// Геттер, возвращающий значение о том, возможно ли произвести [pop].
  bool get canPop;

  /// Удаление последней страницы из стека навигации.
  void pop();

  /// Добавление нового роута в стек навигации.
  void push(
    AppPage page, {
    Object? argument,
  });

  /// Замена текущего стека навигации с помощью списка [PageConfiguration].
  ///
  /// Используется для навигации через диплинк.
  void pushConfigsWithReplacement(List<PageConfiguration> configs);
}

/// Имплементацию сделаем через базовый [ChangeNotifier] для простоты.
/// В своей реализации вы вольны использовать любой подход для state managment.
class RouterPagesManagerImpl extends ChangeNotifier
    implements RouterPagesManager {
  late AppPagesConfig _pagesConfig;

  RouterPagesManagerImpl() {
    _pagesConfig = AppPagesConfig([PageConfiguration(page: AppPage.pageA)]);
  }

  @override
  List<PageConfiguration> get pages => _pagesConfig.pages;

  @override
  bool get canPop => _pagesConfig.length > 1;

  @override
  void pop() {
    // Убедимся, что мы можем безопасно произвести операцию
    if (!canPop) {
      return;
    }

    _pagesConfig.pop();

    // Сообщаем слушателю об удалении пути из стека
    notifyListeners();
  }

  @override
  void push(
    AppPage page, {
    Object? argument,
  }) {
    // Убедимся, что не пытаемся встроить в стек тот же самый путь
    if (page == _pagesConfig.last.page) {
      return;
    }

    final configuration = PageConfiguration(
      page: page,
      argument: argument,
    );
    _pagesConfig.push(configuration);

    // Сообщаем слушателю о добавлении пути из стека
    notifyListeners();
  }

  @override
  void pushConfigsWithReplacement(List<PageConfiguration> configs) {
    _pagesConfig.pushAllWithReplacement(configs);

    // Сообщаем слушателю о замене стека
    notifyListeners();
  }
}
