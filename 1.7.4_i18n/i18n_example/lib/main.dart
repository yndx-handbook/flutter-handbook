import 'package:flutter/material.dart';

import 's.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var _locale = S.en;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: S.supportedLocales,
      locale: _locale,
      localizationsDelegates: S.localizationDelegates,
      builder: (context, child) => Material(
        child: SafeArea(
          child: Stack(
            children: [
              child ?? const SizedBox.shrink(),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkResponse(
                    child: Text(
                      _locale.languageCode.toUpperCase(),
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    onTap: () {
                      final newLocale = S.isEn(_locale) ? S.ru : S.en;
                      setState(() => _locale = newLocale);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: Text(S.of(context).appTitle),
      ),
      body: Center(
        child: Text(
          S
              .of(context)
              .pushCount(DateTime.now(), _counter, PronounStyle.informal),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PronounStyle {
  static const formal = 'formal';
  static const informal = 'informal';
}
