import 'package:flutter/material.dart';

void main() {
  runApp(ThemedApp());
}

class ThemedApp extends StatefulWidget {
  @override
  State<ThemedApp> createState() => _ThemedAppState();
}

class _ThemedAppState extends State<ThemedApp> {
  bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildThemeSwitcher(context),
            const SizedBox(height: 48),
            _PinCode(),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSwitcher(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _isDarkTheme ? 'Dark' : 'Light',
            style: const TextStyle(fontSize: 18),
          ),
          const Spacer(),
          const Icon(Icons.sunny),
          Switch(
            value: _isDarkTheme,
            onChanged: (bool value) {
              setState(() {
                _isDarkTheme = value;
              });
            },
          ),
          const Icon(Icons.nightlight),
        ],
      ),
    );
  }
}

class _PinCode extends StatefulWidget {
  @override
  State<_PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<_PinCode> {
  String _enteredPin = '';
  _PinStatus _status = _PinStatus.regular;

  static const _correctPin = '1234';

  @override
  Widget build(BuildContext context) {
    final String text;
    final Color? textColor;
    switch (_status) {
      case _PinStatus.regular:
        text = List.generate(_enteredPin.length, (_) => "*").join(' ');
        textColor = null;
        break;
      case _PinStatus.correct:
        text = 'Correct pin!';
        textColor = Colors.green.shade800;
        break;
      case _PinStatus.wrong:
        text = 'Wrong pin =(';
        textColor = Colors.red.shade600;
        break;
    }
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: textColor,
          ),
        ),
        const SizedBox(height: 48),
        SizedBox(
          width: 300,
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: List.generate(9, (index) {
              final value = index + 1;
              return GestureDetector(
                onTap: _status == _PinStatus.regular
                    ? () => _onTapNumber(value)
                    : null,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.grey.shade500,
                  child: Text(
                    value.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  void _onTapNumber(int value) {
    setState(() {
      _enteredPin += value.toString();

      if (_enteredPin.length == _correctPin.length) {
        final isCorrectPin = _enteredPin == _correctPin;

        _status = isCorrectPin ? _PinStatus.correct : _PinStatus.wrong;
        _resetStateAfterDelay();
      }
    });
  }

  void _resetStateAfterDelay() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _enteredPin = '';
          _status = _PinStatus.regular;
        });
      }
    });
  }
}

enum _PinStatus {
  regular,
  correct,
  wrong,
}
