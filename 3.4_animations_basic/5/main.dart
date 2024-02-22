import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const OnEndExampleWrapper(),
    );
  }
}

class OnEndExample extends StatelessWidget {
  final Color color;
  final Curve curve;
  final Alignment alignment;
  final VoidCallback onEnd;

  const OnEndExample({
    required this.color,
    required this.curve,
    required this.onEnd,
    required this.alignment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: alignment,
      duration: const Duration(seconds: 1),
      curve: curve,
      onEnd: onEnd,
      child: GestureDetector(
        child: Card(
          color: color,
          child: const SizedBox(
            width: 100.0,
            height: 100.0,
          ),
        ),
      ),
    );
  }
}

class OnEndExampleWrapper extends StatefulWidget {
  const OnEndExampleWrapper({super.key});

  @override
  State<OnEndExampleWrapper> createState() => _OnEndExampleWrapperState();
}

class _OnEndExampleWrapperState extends State<OnEndExampleWrapper> {
  bool firstAnimate = false;
  bool secondAnimate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: OnEndExample(
                      curve: Curves.linear,
                      color: Colors.blue,
                      alignment: firstAnimate
                          ? Alignment.center
                          : Alignment.bottomCenter,
                      onEnd: () {
                        setState(() {
                          if (firstAnimate == true) {
                            secondAnimate = true;

                            return;
                          }

                          firstAnimate = true;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100.0),
                    child: OnEndExample(
                      curve: Curves.linear,
                      color: Colors.red,
                      alignment: secondAnimate
                          ? Alignment.topCenter
                          : Alignment.center,
                      onEnd: () {
                        setState(() {
                          if (secondAnimate == false) {
                            firstAnimate = false;

                            return;
                          }

                          secondAnimate = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  firstAnimate = !firstAnimate;
                });
              },
              child: const Text('Анимировать'),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
