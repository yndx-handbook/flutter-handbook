import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const Scaffold(
        body: Center(
          child: ColorTweenExample(),
        ),
      ),
    );
  }
}

class ColorTweenExample extends StatefulWidget {
  const ColorTweenExample({super.key});

  @override
  State<ColorTweenExample> createState() => _ColorTweenExampleState();
}

class _ColorTweenExampleState extends State<ColorTweenExample> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: TweenAnimationBuilder(
        tween: ColorTween(
          begin: Colors.blue,
          end: isSelected ? Colors.blue : Colors.red,
        ),
        duration: const Duration(milliseconds: 700),
        builder: (context, value, child) => Card(
          color: value,
          child: const SizedBox(
            height: 150,
            width: 150,
            child: Center(
              child: Text('Анимировать'),
            ),
          ),
        ),
      ),
    );
  }
}
