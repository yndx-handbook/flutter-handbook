import 'package:flutter/material.dart';

/// Пример простейшей анимации

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const AnimExample(),
    );
  }
}

class AnimExample extends StatefulWidget {
  const AnimExample({super.key});

  @override
  State<AnimExample> createState() => _AnimExampleState();
}

class _AnimExampleState extends State<AnimExample>
    with SingleTickerProviderStateMixin<AnimExample> {
  late final _controller = AnimationController(
    vsync: this,
    duration: Durations.long4,
  )
    ..addListener(_update)
    // для более интерактивного примера
    ..addStatusListener(_checkStatus)
    ..forward();

  late final _anim = _controller.view;

  bool _needToggleDirection = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Opacity(
          opacity: _anim.value,
          child: GestureDetector(
            onTap: _needToggleDirection
                ? _controller.reverse
                : _controller.forward,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.deepPurpleAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_update);
    _controller.removeStatusListener(_checkStatus);
    _controller.dispose();
    super.dispose();
  }

  void _update() => setState(() {});

  void _checkStatus(AnimationStatus status) {
    _needToggleDirection = status == AnimationStatus.completed;
  }
}