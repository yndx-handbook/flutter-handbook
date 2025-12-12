import 'package:flutter/material.dart';

class MyHomePageWithArgs extends StatefulWidget {
  final String title;
  final List<String> args;

  const MyHomePageWithArgs({
    super.key,
    required this.title,
    required this.args,
  });

  @override
  State<MyHomePageWithArgs> createState() => _MyHomePageWithArgsState();
}

class _MyHomePageWithArgsState extends State<MyHomePageWithArgs> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Arguments from native:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.args.isEmpty ? 'No arguments passed' : widget.args.join(', '),
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Передаем аргумент в UserPage
                final userId = widget.args.isNotEmpty ? widget.args[0] : 'user-123';
                Navigator.pushNamed(
                  context,
                  'user',
                  arguments: userId,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Open User Page with Argument'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}

