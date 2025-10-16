import 'package:flutter/cupertino.dart';
import 'package:navigation_example/src/navigation/config/page_config.dart';
import 'package:navigation_example/src/navigation/utils/arguments.dart';

import '../config/pages_config.dart';

class AppRouteInformationParser extends RouteInformationParser<AppPagesConfig> {
  const AppRouteInformationParser();

  @override
  Future<AppPagesConfig> parseRouteInformation(
    RouteInformation routeInformation,
  ) {
    final pages = <PageConfiguration>[];

    final uri = routeInformation.uri;
    // Сегменты пути и есть наш стек навигации, обработаем каждый
    final segments = uri.pathSegments;
    // Возьмем информацию из queryParams для создания аргументов
    final queryParams = uri.queryParameters;

    // Соберем наш стек страниц из uri входящего [RouteInformation]
    for (int i = 0; i < segments.length; i++) {
      final path = segments[i];
      // Для последнего сегмента (экрана) попробуем взять аргумент из
      // queryParams
      String? argument;
      if (i == segments.length - 1) {
        argument = queryParams[AppNavigationArguments.name];
      }

      pages.add(
        PageConfiguration.fromPath(
          pathName: path,
          argument: argument,
        ),
      );
    }

    if (pages.isEmpty) {
      pages.add(PageConfiguration(page: AppPage.unknown));
    }

    return Future.value(AppPagesConfig(pages));
  }

  /// Данный метод реализован только для примера.
  ///
  /// В общем случае для мобильного приложения реализация не нужна.
  @override
  RouteInformation? restoreRouteInformation(
    AppPagesConfig configuration,
  ) {
    String location = '';
    for (final pageConfig in configuration.pages) {
      location += pageConfig.page.location;
    }

    return RouteInformation(
      uri: Uri.parse(location),
    );
  }
}
