import 'package:flutter/material.dart';

void main() {
  runApp(
    const HelloApp(
      text: 'Hello, I am StatelessWidget!',
    ),
  );
}

class HelloApp extends StatelessWidget {
  final IconData icon;
  final String text;

  const HelloApp({
    required this.text,
    this.icon = Icons.bolt,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 32,
          textDirection: TextDirection.ltr,
        ),
        Text(
          text,
          textDirection: TextDirection.ltr,
        ),
      ],
    );
  }
}
