import 'package:flutter/material.dart';

/// Intervals

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
      home: const ButtonScreen(),
    );
  }
}

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: _Button()),
    );
  }
}

class _Button extends StatefulWidget {
  const _Button();

  @override
  State<_Button> createState() => _ButtonState();
}

class _ButtonState extends State<_Button>
    with SingleTickerProviderStateMixin<_Button> {
  late final AnimationController _scaleController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 600,
    ),
  );

  late final Animation<double> _hide = Tween<double>(
    begin: 1,
    end: 0,
  ).animate(
    CurvedAnimation(
      parent: _scaleController,
      curve: const Interval(
        0,
        0.5,
      ),
    ),
  );
  late final Animation<double> _show = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(
    CurvedAnimation(
      parent: _scaleController,
      curve: const Interval(
        0.5,
        1,
      ),
    ),
  );

  bool _isLoading = false;

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: AnimatedBuilder(
            animation: _show,
            child: Center(
              child: GestureDetector(
                onTap: _handleTap,
                child: const _Loader(),
              ),
            ),
            builder: (context, child) {
              return Transform.scale(
                scale: _show.value,
                child: child,
              );
            },
          ),
        ),
        Center(
          child: SizedBox(
            width: 250,
            height: 56,
            child: AnimatedBuilder(
              animation: _hide,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                onPressed: _handleTap,
                child: const Center(child: Text('TAP ME')),
              ),
              builder: (context, child) {
                return Transform.scale(
                  scale: _hide.value,
                  child: child,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _handleTap() {
    if (_isLoading) {
      _scaleController.reverse();
    } else {
      _scaleController.forward();
    }

    setState(() {
      _isLoading = !_isLoading;
    });
  }
}

class _Loader extends StatelessWidget {
  const _Loader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 49,
      height: 49,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.redAccent,
      ),
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(11),
      child: const CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}