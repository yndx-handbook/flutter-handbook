import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Bulb(),
    ),
  );
}

class Bulb extends StatefulWidget {
  const Bulb({
    super.key,
  });

  @override
  State<Bulb> createState() => _BulbState();
}

class _BulbState extends State<Bulb> {
  bool _isLightOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isLightOn ? Colors.white : Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lightbulb,
              size: 32,
              color: _isLightOn ? Colors.yellow : Colors.grey,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: Text(_isLightOn ? 'Выключить свет' : 'Включить свет'),
              onPressed: () {
                setState(() {
                  _isLightOn = !_isLightOn;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
