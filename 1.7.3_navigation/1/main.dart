import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageA(),
    );
  }
}

class YandexColors {
  static const red = Color(0xFFFF2C00);
  static const green = Color(0xFF00DA72);
  static const blue = Color(0xFF4042EE);
}

class PageA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page A'),
        backgroundColor: YandexColors.blue,
      ),
      body: Center(
        child: TextButton(
          child: const Text('Go to «Page B»'),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PageB()));
          },
        ),
      ),
    );
  }
}

class PageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Page B'),
          backgroundColor: YandexColors.green,
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text('Go back'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 16),
              TextButton(
                child: const Text('Go to «Page C»'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PageC())
                  );
                },
              ),
            ],
          ),
        )
    );
  }
}

class PageC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page C'),
        backgroundColor: YandexColors.red,
      ),
      body: Center(
        child: TextButton(
          child: const Text('Go back'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}