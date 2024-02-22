import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const CurvesExampleWrapper(),
    );
  }
}

class CurvesExample extends StatelessWidget {
  final bool selected;
  final Color color;
  final Curve curve;

  const CurvesExample({
    required this.selected,
    required this.color,
    required this.curve,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: selected ? Alignment.bottomCenter : Alignment.topCenter,
      duration: const Duration(seconds: 1),
      curve: curve,
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

class CurvesExampleWrapper extends StatefulWidget {
  const CurvesExampleWrapper({super.key});

  @override
  State<CurvesExampleWrapper> createState() => _CurvesExampleWrapperState();
}

class _CurvesExampleWrapperState extends State<CurvesExampleWrapper> {
  bool selected = false;

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
                    padding: const EdgeInsets.only(right: 116.0),
                    child: CurvesExample(
                      selected: selected,
                      curve: Curves.linear,
                      color: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 116.0),
                    child: CurvesExample(
                      selected: selected,
                      curve: Curves.easeIn,
                      color: Colors.red,
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
                  selected = !selected;
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
