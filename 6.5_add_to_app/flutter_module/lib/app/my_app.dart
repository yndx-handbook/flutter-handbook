import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/user_page.dart';

/// Первая точка входа: обычный каунтер с навигацией
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        'user': (context) => const UserPage(userId: '123'),
      },
    );
  }
}

