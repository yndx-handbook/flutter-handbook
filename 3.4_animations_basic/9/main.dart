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
          child: AnimatedFlipWrapper(),
        ),
      ),
    );
  }
}

class AnimatedFlip extends StatelessWidget {
  final Widget front;
  final Widget back;
  final VoidCallback onTap;
  final bool isFlipped;

  const AnimatedFlip({
    required this.front,
    required this.back,
    required this.onTap,
    required this.isFlipped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOut,
        tween: Tween<double>(
          begin: 0,
          end: isFlipped ? 180 : 0,
        ),
        builder: (context, value, child) {
          final content = value < 90
              ? front
              : RotationY(
                  rotationY: 180,
                  child: back,
                );

          return RotationY(
            rotationY: value,
            child: content,
          );
        },
      ),
    );
  }
}

class AnimatedFlipWrapper extends StatefulWidget {
  const AnimatedFlipWrapper({super.key});

  @override
  State<AnimatedFlipWrapper> createState() => _AnimatedFlipWrapperState();
}

class _AnimatedFlipWrapperState extends State<AnimatedFlipWrapper> {
  bool isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedFlip(
      front: const Card(
        color: Colors.red,
        child: SizedBox(
          width: 150,
          height: 150,
        ),
      ),
      back: const Card(
        color: Colors.blue,
        child: SizedBox(
          width: 150,
          height: 150,
          child: Center(
            child: Text('Яндекс Образование'),
          ),
        ),
      ),
      isFlipped: isFlipped,
      onTap: () {
        setState(() {
          isFlipped = !isFlipped;
        });
      },
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
