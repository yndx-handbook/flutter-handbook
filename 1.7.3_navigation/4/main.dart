import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/A',
      routes: {
        '/A': (context) => PageA(),
        '/B': (context) => PageB(),
      },
    );
  }
}

class YandexColors {
  static const green = Color(0xFF00DA72);
  static const blue = Color(0xFF4042EE);
}

class PageA extends StatefulWidget {
  @override
  State<PageA> createState() => _PageAState();
}

class _PageAState extends State<PageA> {
  String _name = 'Alex';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page A'),
        backgroundColor: YandexColors.blue,
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your name is: «$_name»'),
            TextButton(
              child: const Text('Edit name'),
              onPressed: () async { // Используем ключевое слово async
                final result = await Navigator.pushNamed<String?>(context, '/B', arguments: _name);
                if (result != null) {
                  setState(() {
                    _name = result;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PageB extends StatefulWidget {
  const PageB({super.key});

  @override
  State<PageB> createState() => _PageBState();
}

class _PageBState extends State<PageB> {
  final _textFieldController = TextEditingController(text: '');

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Page B'),
          backgroundColor: YandexColors.green,
        ),
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
                child: TextField(
                  controller: _textFieldController,
                ),
              ),
              TextButton(
                child: const Text('Save'),
                onPressed: () => Navigator.pop(context, _textFieldController.text),
              ),
            ],
          ),
        )
    );
  }
}