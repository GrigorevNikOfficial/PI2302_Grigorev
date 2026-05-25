import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Возвращение значения',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.blue)),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) =>
            const MyHomePage(title: 'Возвращение значения'),
        '/second': (BuildContext context) => const SecondPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  Future<void> _openSecondPage(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/second');
    if (!context.mounted || result == null) {
      return;
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ваш выбор: $result'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _openSecondPage(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Приступить к выбору...'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выберите любой вариант'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Да!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text('Да!'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Нет.');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text('Нет.'),
            ),
          ],
        ),
      ),
    );
  }
}
