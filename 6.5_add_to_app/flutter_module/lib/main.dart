import 'package:flutter/material.dart';
import 'app/my_app.dart';
import 'app/my_app_with_args.dart';
import 'app/my_compact_widget.dart';

// Точка входа 1: обычный каунтер с роутом до UserPage
void main() => runApp(const MyApp());

// Точка входа 2: страница с аргументами и каунтер, с возможностью открыть UserPage
@pragma('vm:entry-point')
void mainWithArgs(List<String> args) => runApp(MyAppWithArgs(args: args));

// Точка входа 3: простой виджет для компактного отображения
@pragma('vm:entry-point')
void mainWidget(List<String> args) => runApp(MyCompactWidget(args: args));
