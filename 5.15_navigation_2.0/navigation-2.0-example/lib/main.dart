import 'package:flutter/material.dart';
import 'package:navigation_example/src/navigation/router/route_information_parser.dart';

import 'src/navigation/router/router_delegate.dart';
import 'src/navigation/state/router_scope.dart';

/// Глобальный ключ навигации, который прокинем в наш [AppRouterDelegate].
final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

void main() {
  // Оборачиваем наше дерево в скоуп для доступа к менеджеру навигации ниже
  // по дереву.
  runApp(const RouterScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем к менеджеру из созданного скоупа
    final pagesManager = RouterScope.managerOf(context, listen: true);

    // Используем для создания именованный конструктор [MaterialApp]
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // Задаем свой [RouteInformationParser] для обработки диплинков
      routeInformationParser: const AppRouteInformationParser(),
      // Задаем свой [RouterDelegate]
      routerDelegate: AppRouterDelegate(
        navigatorKey: _navigatorKey,
        manager: pagesManager,
      ),
    );
  }
}
