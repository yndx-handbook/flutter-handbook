import 'package:flutter/widgets.dart';

/// Конфигурация базового экрана. Содержит в себе enum-тип экрана и аргумент,
/// опциональный при создании конфигурации.
class PageConfiguration {
  late final AppPage page;

  /// Note: хорошим тоном будет использование Map<String, Object?> для
  /// возможности прокидывать сразу несколько параметров и обращаться к ним
  /// через ключи. Здесь используется Object? для облегчения примера.
  final Object? argument;

  /// Вспомогательный словарь, позволяющий получать enum-тип из строкового
  /// названия пути.
  static final Map<String, AppPage> _pagePathsMap = {
    AppPage.unknown.pathName: AppPage.unknown,
    AppPage.pageA.pathName: AppPage.pageA,
    AppPage.pageB.pathName: AppPage.pageB,
    AppPage.pageC.pathName: AppPage.pageC,
  };

  PageConfiguration({
    required this.page,
    this.argument,
  });

  /// Дополнительный именованный конструктор, позволяющий создать страницу
  /// через строковый путь.
  PageConfiguration.fromPath({
    required String pathName,
    this.argument,
  }) {
    page = _resolvePage(pathName);
  }

  /// Переопределяем [hashCode] и оператор сравнения для корректного сравнения
  /// различных [PageConfiguration].
  @override
  int get hashCode => Object.hash(page, argument);

  @override
  bool operator ==(Object other) =>
      other is PageConfiguration &&
      runtimeType == other.runtimeType &&
      page == other.page &&
      argument == other.argument;

  /// Вспомогательный метод, производящий маппинг строкового пути к enum-типу
  /// страницы.
  static AppPage _resolvePage(String? path) {
    return _pagePathsMap[path] ?? AppPage.unknown;
  }
}

/// Enum-тип для экранов приложения.
enum AppPage {
  /// Неизвестный корневой путь. По дефолту в данном примере будем производить
  /// навигацию на страницу А.
  unknown('/'),

  /// Тип для страницы A.
  pageA('page_A'),

  /// Тип для страницы B.
  pageB('page_B'),

  /// Тип для страницы C.
  pageC('page_C');

  /// Параметр, позволяющий хранить знание о названии пути определенной
  /// страницы.
  final String pathName;

  const AppPage(this.pathName);

  /// Геттер, создающий так называемый location, который используется в
  /// [RouteInformation].
  String get location => this == AppPage.unknown ? pathName : '/$pathName';
}
