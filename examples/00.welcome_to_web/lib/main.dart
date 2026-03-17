import 'package:flutter/material.dart';

import 'app_js_functions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _videoAdded = false;

  @override
  void initState() {
    super.initState();
    setCallback();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    consoleLog('Счётчик: $_counter');
  }

  void _resetCounter() {
    final ok = showConfirm('Сбросить счётчик?');
    if (ok) {
      setState(() => _counter = 0);
      showBrowserAlert('Счётчик сброшен');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: () => openBrowserWindow('https://flutter.dev'),
            tooltip: 'Открыть Flutter',
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: printPerson,
            tooltip: 'JS Person',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _resetCounter,
              icon: const Icon(Icons.refresh),
              label: const Text('Сбросить (confirm)'),
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.tonal(
                  onPressed: () => showBrowserAlert('Привет из Flutter Web!'),
                  child: const Text('Alert'),
                ),
                FilledButton.tonal(
                  onPressed: () => openNewWindow('https://dart.dev'),
                  child: const Text('Новое окно'),
                ),
                FilledButton.tonal(
                  onPressed: () {
                    addVideoElement();
                    setState(() => _videoAdded = true);
                  },
                  child: const Text('Добавить видео'),
                ),
                FilledButton.tonal(
                  onPressed: _videoAdded
                      ? () {
                          removeVideoElement();
                          setState(() => _videoAdded = false);
                        }
                      : null,
                  child: const Text('Удалить видео'),
                ),
              ],
            ),
          ],
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
