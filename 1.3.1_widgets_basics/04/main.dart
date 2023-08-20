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
        _GradientBackground(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: 32,
            color: Colors.white,
            textDirection: TextDirection.ltr,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          text,
          textDirection: TextDirection.ltr,
        ),
      ],
    );
  }
}

class _GradientBackground extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const _GradientBackground({
    required this.child,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: <Color>[
            Color(0xff1f005c),
            Color(0xff5b0060),
            Color(0xff870160),
            Color(0xffac255e),
            Color(0xffca485c),
            Color(0xffe16b5c),
            Color(0xfff39060),
            Color(0xffffb56b),
          ],
        ),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
