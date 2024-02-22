import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _compassAnimation;
  late final Tween<double> _compassTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _compassTween = Tween(
      begin: _nextAngle(),
      end: _nextAngle(),
    );
    _compassAnimation = _compassTween
        .chain(CurveTween(curve: Curves.easeInOutBack))
        .animate(_controller);

    _controller
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _compassTween.begin = _compassAnimation.value;
            _compassTween.end = _nextAngle();
          });
          _controller
            ..reset()
            ..forward();
        }
      })
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: _compassAnimation,
              builder: (context, child) => CustomPaint(
                painter: CompasPainter(angle: _compassAnimation.value),
                willChange: true,
                child: Container(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static double _nextAngle() => math.Random().nextDouble() * (math.pi * 2);
}

class CompasPainter extends CustomPainter {
  final double angle;

  const CompasPainter({this.angle = 0});

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..color = Colors.red;

    // Координата Y середины холста
    final verticalCenter = size.height / 2;
    // Координата X середины холста
    final horizontalCenter = size.width / 2;
    // Середина холста
    final center = Offset(horizontalCenter, verticalCenter);
    // Радиус окружности
    final radius = size.shortestSide / 6;

    // Рисуем подложку компаса
    canvas.drawCircle(
      center,
      radius,
      Paint()..color = Colors.grey,
    );

    final circleTopPoint = center.translate(0, -radius);
    final circleBottomPoint = center.translate(0, radius);
    final circleLeftPoint = center.translate(-radius, 0);
    final circleRightPoint = center.translate(radius, 0);

    // Рисуем буквы-обозначения на компасе
    const textStyle = TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
    final textPainter = TextPainter();
    textPainter
      ..textDirection = TextDirection.ltr
      ..text = const TextSpan(
        style: textStyle,
        text: 'N',
      )
      ..layout(maxWidth: size.width)
      ..paint(
        canvas,
        circleTopPoint.translate(-textPainter.width / 2, 0),
      )
      ..text = const TextSpan(
        style: textStyle,
        text: 'S',
      )
      ..layout(maxWidth: size.width)
      ..paint(
        canvas,
        circleBottomPoint.translate(
            -textPainter.width / 2, -textPainter.height),
      )
      ..text = const TextSpan(
        style: textStyle,
        text: 'W',
      )
      ..layout(maxWidth: size.width)
      ..paint(
        canvas,
        circleLeftPoint.translate(0, -textPainter.height / 2),
      )
      ..text = const TextSpan(
        style: textStyle,
        text: 'E',
      )
      ..layout(maxWidth: size.width)
      ..paint(
        canvas,
        circleRightPoint.translate(-textPainter.width, -textPainter.height / 2),
      );

    canvas.save();

    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle.clamp(0, math.pi * 2));
    canvas.translate(-center.dx, -center.dy);

    const markerRadius = 10;

    /// Рисуем красную часть стрелки
    canvas.drawPath(
      Path()
        ..moveTo(circleTopPoint.dx, circleTopPoint.dy)
        ..lineTo(center.dx + markerRadius, center.dy)
        ..lineTo(center.dx - markerRadius, center.dy)
        ..close(),
      painter..color = Colors.red,
    );

    /// Рисуем синюю часть стрелки
    canvas.drawPath(
      Path()
        ..moveTo(circleBottomPoint.dx, circleBottomPoint.dy)
        ..lineTo(center.dx + markerRadius, center.dy)
        ..lineTo(center.dx - markerRadius, center.dy)
        ..close(),
      painter..color = Colors.blue,
    );

    /// Рисуем "гвоздик" по центру стрелки
    canvas.drawCircle(
      center,
      markerRadius + 2,
      Paint()..color = Colors.black,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(CompasPainter oldDelegate) => angle != oldDelegate.angle;
}
