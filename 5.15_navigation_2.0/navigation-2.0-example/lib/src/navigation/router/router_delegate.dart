import 'package:flutter/material.dart';
import 'package:navigation_example/src/navigation/config/page_config.dart';

import '../../pages/pages.dart';
import '../config/pages_config.dart';
import '../state/router_pages_manager.dart';
import 'route_information_parser.dart';

class AppRouterDelegate extends RouterDelegate<AppPagesConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppPagesConfig> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  /// Прокидываем в качестве зависимости наш менеджер для доступа к текущему
  /// состоянию конфигурации [AppPagesConfig] и методам менеджера
  final RouterPagesManager manager;

  AppRouterDelegate({
    required this.navigatorKey,
    required this.manager,
  }) {
    // Подписываемся на изменения нашего хранителя состояния и производим
    // перестроение навигации, если что-то поменялось
    manager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    manager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Navigator(
        key: navigatorKey,
        pages: _resolvePages(manager.pages).toList(growable: false),
        onPopPage: _onPopPage,
        // onDidRemovePage: (page) {
        //   manager.removePageByName(page.name);
        // },
      );

  /// Метод вызывается сразу после работы
  /// [AppRouteInformationParser.parseRouteInformation].
  ///
  /// Заменяем текущий стек новой конфигурацией, чтобы не произошло накладки
  /// экранов.
  @override
  Future<void> setNewRoutePath(AppPagesConfig configuration) async {
    return manager.pushConfigsWithReplacement(configuration.pages);
  }

  /// Генератор, предназначенный для маппинга текущего списка конфигурации в
  /// соответствующие экраны. Используем стандартную обертку [MaterialPage].
  ///
  /// Note: вы вольны создать свой/свои наследник(-и) [Page], чтобы
  /// кастомизировать поведение экранов при встраивании в стек навигации,
  /// например, [PageTransitionsBuilder].
  Iterable<Page> _resolvePages(List<PageConfiguration> configs) sync* {
    for (final config in configs) {
      switch (config.page) {
        case AppPage.unknown:
          yield MaterialPage(child: const PageA(), arguments: config.argument);
          break;
        case AppPage.pageA:
          yield MaterialPage(child: const PageA(), arguments: config.argument);
          break;
        case AppPage.pageB:
          yield MaterialPage(child: const PageB(), arguments: config.argument);
          break;
        case AppPage.pageC:
          yield MaterialPage(child: const PageC(), arguments: config.argument);
          break;
      }
    }
  }

  bool _onPopPage(Route<Object?> route, Object? result) {
    /// Не даем закрыть единственную страницу в стеке навигации
    if (route.isFirst && route.isActive) {
      return false;
    }

    // Для объяснения данного действия рекомендую посмотреть этот комментарий
    // на stackoverflow: <https://stackoverflow.com/a/65810416>
    if (!route.didPop(result)) {
      return false;
    }

    // Производим pop с помощью нашего [RouterPagesNotifier], если можем
    manager.pop();
    return true;
  }
}
