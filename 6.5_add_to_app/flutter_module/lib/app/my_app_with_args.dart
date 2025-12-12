import 'package:flutter/material.dart';
import '../pages/home_page_with_args.dart';
import '../pages/user_page.dart';

/// Вторая точка входа: приложение с аргументами
class MyAppWithArgs extends StatelessWidget {
  final List<String> args;

  const MyAppWithArgs({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter With Args',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == 'user') {

          final userId = settings.arguments as String? ?? 
                        (args.isNotEmpty ? args[0] : 'default-user');
          return MaterialPageRoute(
            builder: (context) => UserPage(userId: userId),
          );
        }

        return MaterialPageRoute(
          builder: (context) => MyHomePageWithArgs(
            title: 'Flutter With Args',
            args: args,
          ),
        );
      },
    );
  }
}

