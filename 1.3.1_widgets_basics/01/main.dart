import 'package:flutter/material.dart';

void main() {
  runApp(
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.bolt,
          size: 32,
          textDirection: TextDirection.ltr,
        ),
        Text(
          'Hello, Widget World!',
          textDirection: TextDirection.ltr,
        ),
      ],
    ),
  );
}
