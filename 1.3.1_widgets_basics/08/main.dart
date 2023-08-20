import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(home: RandomizerPage()));
}

class InheritedNumber extends InheritedWidget {
  const InheritedNumber({
    required this.number,
    required super.child,
    super.key,
  });

  final int number;

  static InheritedNumber? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedNumber>();
  }

  static InheritedNumber of(BuildContext context) {
    final InheritedNumber? result = maybeOf(context);
    assert(result != null, 'No InheritedNumber found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedNumber oldWidget) =>
      number != oldWidget.number;
}

class RandomizerPage extends StatefulWidget {
  @override
  State<RandomizerPage> createState() => _RandomizerPageState();
}

class _RandomizerPageState extends State<RandomizerPage> {
  final rand = Random();
  late int _randomNumber = rand.nextInt(100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InheritedNumber(
        number: _randomNumber,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _randomNumber = rand.nextInt(100);
                  });
                },
                child: const Text('Refresh'),
              ),
              const SizedBox(height: 16),
              Text('Number in RandomizerPage: $_randomNumber'),
              const SizedBox(height: 16),
              _Child(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Child extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Number in _Child: ${InheritedNumber.of(context).number}',
    );
  }
}
