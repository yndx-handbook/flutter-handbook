import 'package:flutter/material.dart';

import '../navigation/config/page_config.dart';
import '../navigation/state/router_scope.dart';

abstract class YandexColors {
  static const red = Color(0xFFFF2C00);
  static const green = Color(0xFF00DA72);
  static const blue = Color(0xFF4042EE);
}

class PageA extends StatelessWidget {
  const PageA({super.key});

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
          onPressed: () => RouterScope.managerOf(context).push(AppPage.pageB),
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
                decoration: const InputDecoration(hintText: 'Enter your name'),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              child: const Text('Go back'),
              onPressed: () => RouterScope.managerOf(context).pop(),
            ),
            const SizedBox(height: 16),
            TextButton(
              child: const Text('Go to «Page C»'),
              onPressed: () => RouterScope.managerOf(context).push(
                AppPage.pageC,
                argument: _textFieldController.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageC extends StatelessWidget {
  const PageC({super.key});

  @override
  Widget build(BuildContext context) {
    /// Получаем аргумент из навигации, может быть nullable, поэтому будем
    /// внимательны при typecast
    final userName = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page C'),
        backgroundColor: YandexColors.red,
      ),
      body: Center(
        child: Text('Hello, $userName'),
      ),
    );
  }
}
