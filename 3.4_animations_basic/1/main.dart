import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const AnimatedAlignmentExampleWrapper(),
    );
  }
}

class AnimatedAlignmentExample extends StatelessWidget {
  final bool selected;

  const AnimatedAlignmentExample({required this.selected, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: selected ? Alignment.bottomCenter : Alignment.topCenter,
      duration: const Duration(seconds: 1),
      child: GestureDetector(
        child: const Card(
          color: Colors.blue,
          child: SizedBox(
            width: 100.0,
            height: 100.0,
          ),
        ),
      ),
    );
  }
}

class AnimatedAlignmentExampleWrapper extends StatefulWidget {
  const AnimatedAlignmentExampleWrapper({super.key});

  @override
  State<AnimatedAlignmentExampleWrapper> createState() =>
      _AnimatedAlignmentExampleWrapperState();
}

class _AnimatedAlignmentExampleWrapperState
    extends State<AnimatedAlignmentExampleWrapper> {
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
                  AnimatedAlignmentExample(
                    selected: selected,
                  )
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
