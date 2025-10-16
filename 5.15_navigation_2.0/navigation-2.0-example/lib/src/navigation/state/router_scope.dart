import 'package:flutter/cupertino.dart';

import 'router_pages_manager.dart';

/// Данный виджет нужен для встраивания [_RouterScopeInherited] в дерево
/// виджетов и управления зависимостями через ЖЦ самого виджета.
class RouterScope extends StatefulWidget {
  final Widget child;

  const RouterScope({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<RouterScope> createState() => _RouterScopeState();

  /// Данный метод используется в деревьях, обернутых в сам скоуп.
  ///
  /// Дает доступ к интерфейсу менеджера навигации.
  static RouterPagesManager managerOf(
    BuildContext context, {
    bool listen = false,
  }) =>
      _RouterScopeInherited.of(context, listen: listen);
}

class _RouterScopeState extends State<RouterScope> {
  late final RouterPagesManagerImpl manager;

  @override
  void initState() {
    super.initState();
    // Создаем экземпляр менеджера при встраивании в дерево
    manager = RouterPagesManagerImpl();
  }

  @override
  void dispose() {
    // Вызываем диспоуз менеджера при удалении из дерева
    manager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _RouterScopeInherited(
        pagesManager: manager,
        child: widget.child,
      );
}

/// Стандартный [InheritedWidget] для хранения нашего [RouterPagesManagerImpl].
class _RouterScopeInherited extends InheritedWidget {
  /// Используем интерфейс менеджера для соблюдения инверсии зависимостей
  final RouterPagesManager pagesManager;

  const _RouterScopeInherited({
    required this.pagesManager,
    required super.child,
  });

  static RouterPagesManager of(
    BuildContext context, {
    bool listen = false,
  }) {
    final manager = maybeOf(context);
    return ArgumentError.checkNotNull(manager);
  }

  static RouterPagesManager? maybeOf(
    BuildContext context, {
    bool listen = false,
  }) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<_RouterScopeInherited>()
          ?.pagesManager;
    } else {
      return (context
              .getElementForInheritedWidgetOfExactType<_RouterScopeInherited>()
              ?.widget as _RouterScopeInherited?)
          ?.pagesManager;
    }
  }

  @override
  bool updateShouldNotify(_RouterScopeInherited oldWidget) =>
      oldWidget.pagesManager != pagesManager;
}
