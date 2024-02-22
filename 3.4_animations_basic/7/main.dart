import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const Scaffold(
        backgroundColor: Color(0xFFd9e2fc),
        body: Center(
          child: AnimatedFlip(),
        ),
      ),
    );
  }
}

class AnimatedFlip extends StatefulWidget {
  const AnimatedFlip({super.key});

  @override
  State<AnimatedFlip> createState() => _AnimatedFlipState();
}

class _AnimatedFlipState extends State<AnimatedFlip> {
  bool _isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFlipped = !_isFlipped;
        });
      },
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOut,
        tween: Tween<double>(begin: 0, end: _isFlipped ? 180 : 0),
        builder: (context, value, child) {
          return RotationY(
            rotationY: value,
            child: const Card(
              child: SizedBox(
                width: 150,
                height: 150,
              ),
            ),
          );
        },
      ),
    );
  }
}

class RotationY extends StatelessWidget {
  static const double _degrees2Radians = pi / 180;

  final Widget child;
  final double rotationY;

  const RotationY({
    required this.child,
    this.rotationY = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(rotationY * _degrees2Radians),
      child: child,
    );
  }
}
