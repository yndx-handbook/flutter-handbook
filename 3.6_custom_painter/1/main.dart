import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() async => runApp(const MyApp());

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => CustomPaint(
                painter: HousePainter(timeOfDayAnimation: _controller),
                willChange: true,
                child: Container(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HousePainter extends CustomPainter {
  /// Value 0.0 - night
  /// Value 1.0 - day
  final Animation<double> timeOfDayAnimation;

  const HousePainter({
    required this.timeOfDayAnimation,
  }) : super(repaint: timeOfDayAnimation);

  static final _skyTween = ColorTween(
    end: Colors.blue.shade300,
    begin: Colors.grey.shade800,
  ).chain(CurveTween(curve: Curves.easeInOutQuint));

  static final _windowTween = ColorTween(
    end: Colors.blue.shade600,
    begin: Colors.yellow.shade600,
  ).chain(CurveTween(curve: Curves.easeInOutQuint));

  static const _groundHeight = 100.0;

  static const _houseHeight = 275.0;
  static const _houseWidth = 250.0;
  static const _houseOnGroundOffset = 20;

  static const _doorHeight = _houseHeight * 0.5;
  static const _doorWidth = _houseWidth * 0.3;

  static const _doorHandleHeight = 5.0;
  static const _doorHandleWidth = 15.0;

  static const _windowRadius = 35.0;

  static const _windowRoofThickness = 10.0;

  static const _houseRoofHeight = 75.0;
  static const _houseRoofHorizontalOffset = 25.0;
  static const _houseRoofVerticalOffset = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    _drawSky(canvas);
    _drawGround(canvas, size);
    _drawWalls(canvas, size);
    _drawDoor(canvas, size);
    _drawDoorHandle(canvas, size);
    _drawWindow(canvas, size);
    _drawWindowRoof(canvas, size);
    _drawHouseRoof(canvas, size);
  }

  /// Рисуем крышу дома
  void _drawHouseRoof(Canvas canvas, Size size) {
    final painter = Paint()..color = Colors.pink.shade400;

    // Координата X середины холста
    final horizontalCenter = size.width / 2;
    // Половина от ширины дома
    const halfOfRoofWidth = _houseWidth / 2 + _houseRoofHorizontalOffset;

    final housePositionOnGround =
        size.height - _groundHeight + _houseOnGroundOffset;
    final roofBottomY =
        housePositionOnGround - _houseHeight + _houseRoofVerticalOffset;

    // Левый угол крыши
    final roofLeftX = horizontalCenter - halfOfRoofWidth;
    // Правый угол крыши
    final roofRightX = horizontalCenter + halfOfRoofWidth;

    final path = Path()
      // Сдвигаем курсор на левый угол крыши
      ..moveTo(roofLeftX, roofBottomY)
      // Рисуем линию с левого угла крыши до центра
      ..lineTo(
        horizontalCenter,
        housePositionOnGround - _houseHeight - _houseRoofHeight,
      )
      // Рисуем линию центра до правого угла крыши
      ..lineTo(roofRightX, roofBottomY)
      // Соединяем начальную позицию с конечной
      ..close();

    canvas.drawPath(path, painter);
  }

  /// Рисуем крышу окна
  void _drawWindowRoof(Canvas canvas, Size size) {
    final painter = Paint()
      ..color = Colors.pink.shade400
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = _windowRoofThickness;

    // Координата X середины холста
    final horizontalCenter = size.width / 2;
    // Половина от ширины дома
    const halfOfHouseWidth = _houseWidth / 2;

    final housePositionOnGround =
        size.height - _groundHeight + _houseOnGroundOffset;

    final windowCenterY = housePositionOnGround - _doorHeight * 0.7;
    final windowCenterX =
        horizontalCenter + halfOfHouseWidth - _windowRadius - 40;

    final windowCenter = Offset(windowCenterX, windowCenterY);

    // Размер окна + половина от ширины крыши
    const rectSize = _windowRadius * 2 + _windowRoofThickness / 2;

    final rect = Rect.fromCenter(
      center: windowCenter,
      width: rectSize,
      height: rectSize,
    );

    canvas.drawArc(
      rect,
      // Угол с которого начинаем дугу
      math.pi * 7 / 6,
      // Продолжительность дуги
      math.pi * 4 / 6,
      false,
      painter,
    );
  }

  /// Рисуем окно
  void _drawWindow(Canvas canvas, Size size) {
    final painter = Paint()
      ..color = _windowTween.evaluate(timeOfDayAnimation) ?? Colors.transparent;

    // Координата X середины холста
    final horizontalCenter = size.width / 2;
    // Половина от ширины дома
    const halfOfHouseWidth = _houseWidth / 2;

    final housePositionOnGround =
        size.height - _groundHeight + _houseOnGroundOffset;

    final windowCenterY = housePositionOnGround - _doorHeight * 0.7;

    final windowCenterX =
        horizontalCenter + halfOfHouseWidth - _windowRadius - 40;

    final windowCenter = Offset(windowCenterX, windowCenterY);

    canvas.drawCircle(
      windowCenter,
      _windowRadius,
      painter,
    );
  }

  /// Рисуем дверную ручку
  void _drawDoorHandle(Canvas canvas, Size size) {
    final painter = Paint()
      // Цвет линии
      ..color = Colors.black;

    // Координата X середины холста
    final horizontalCenter = size.width / 2;
    // Половина от ширины дома
    const halfOfHouseWidth = _houseWidth / 2;

    final housePositionOnGround =
        size.height - _groundHeight + _houseOnGroundOffset;

    final doorBottomY = housePositionOnGround - 10;

    final doorLeftX = horizontalCenter - halfOfHouseWidth + 20;

    // Нижняя левая координата двери
    final leftBottomCornerPoint = Offset(
      doorLeftX,
      doorBottomY,
    );

    // Верхняя правая координата двери
    final rightTopCornerPoint = Offset(
      doorLeftX + _doorWidth,
      doorBottomY - _doorHeight,
    );

    final doorRect = Rect.fromPoints(
      leftBottomCornerPoint,
      rightTopCornerPoint,
    );

    final doorHandleCenter = doorRect.centerRight.translate(-15, 0);
    final doorHandleRect = Rect.fromCenter(
      center: doorHandleCenter,
      width: _doorHandleWidth,
      height: _doorHandleHeight,
    );

    canvas.drawOval(doorHandleRect, painter);
  }

  /// Рисуем дверь
  void _drawDoor(Canvas canvas, Size size) {
    final painter = Paint()
      // Цвет линии
      ..color = Colors.orange.shade700;

    // Радиус закругления углов
    const radius = Radius.circular(16);

    // Координата X середины холста
    final horizontalCenter = size.width / 2;
    // Половина от ширины дома
    const halfOfHouseWidth = _houseWidth / 2;

    final housePositionOnGround =
        size.height - _groundHeight + _houseOnGroundOffset;

    final doorBottomY = housePositionOnGround - 10;

    final doorLeftX = horizontalCenter - halfOfHouseWidth + 20;

    // Нижняя левая координата двери
    final leftBottomCornerPoint = Offset(
      doorLeftX,
      doorBottomY,
    );

    // Верхняя правая координата двери
    final rightTopCornerPoint = Offset(
      doorLeftX + _doorWidth,
      doorBottomY - _doorHeight,
    );

    final rect = Rect.fromPoints(
      leftBottomCornerPoint,
      rightTopCornerPoint,
    );

    final rrect = RRect.fromRectAndRadius(
      rect,
      radius,
    );

    canvas.drawRRect(rrect, painter);
  }

  /// Рисуем стены
  void _drawWalls(Canvas canvas, Size size) {
    final painter = Paint()
      // Цвет линии
      ..color = Colors.pink.shade300;

    // Координата X середины холста
    final horizontalCenter = size.width / 2;
    // Половина от ширины дома
    const halfOfHouseWidth = _houseWidth / 2;

    final housePositionOnGround =
        size.height - _groundHeight + _houseOnGroundOffset;

    // Нижняя левая координата дома
    final leftBottomCornerPoint = Offset(
      horizontalCenter - halfOfHouseWidth,
      housePositionOnGround,
    );

    // Верхняя правая координата дома
    final rightTopCornerPoint = Offset(
      horizontalCenter + halfOfHouseWidth,
      housePositionOnGround - _houseHeight,
    );

    final rect = Rect.fromPoints(
      leftBottomCornerPoint,
      rightTopCornerPoint,
    );

    canvas.drawRect(rect, painter);
  }

  /// Рисуем траву
  void _drawGround(Canvas canvas, Size size) {
    final painter = Paint()
      // Цвет линии
      ..color = Colors.green.shade300
      // Ширина линии в пикселях
      ..strokeWidth = _groundHeight;

    // Координата Y линии
    final dY = size.height - painter.strokeWidth / 2;

    final startPoint = Offset(0, dY);
    final endPoint = Offset(size.width, dY);

    canvas.drawLine(
      startPoint,
      endPoint,
      painter,
    );
  }

  /// Рисуем небо
  void _drawSky(Canvas canvas) {
    canvas.drawPaint(Paint()
      ..color = _skyTween.evaluate(timeOfDayAnimation) ?? Colors.transparent);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
