import 'package:flutter/material.dart';
import '../pages/compact_widget_page.dart';

/// Третья точка входа: компактный виджет
class MyCompactWidget extends StatelessWidget {
  final List<String> args;

  const MyCompactWidget({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compact Widget',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: CompactWidgetPage(args: args),
    );
  }
}