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
  const PageA({super.key});

  @override
  State<PageA> createState() => _PageAState();
}

class _PageAState extends State<PageA> {
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
          title: const Text('Page A'),
          backgroundColor: YandexColors.blue,
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
                  decoration: const InputDecoration(
                      hintText: 'Enter your name'
                  ),
                ),
              ),
              TextButton(
                  child: const Text('Say hello'),
                  onPressed: () => Navigator.pushNamed(context, '/B', arguments: _textFieldController.text)
              ),
            ],
          ),
        )
    );
  }
}

class PageB extends StatelessWidget {
  const PageB({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Page B'),
          backgroundColor: YandexColors.green,
        ),
        body: Center(
          child: Text('Hello, $userName'),
        )
    );
  }
}