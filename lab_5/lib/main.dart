import 'package:flutter/material.dart';

import 'simple_list.dart';
import "infinity_list.dart";
import 'infinity_math_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Список элементов',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.green)),
      home: const MyHomePage(title: 'Список элементов'),
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
  void _openPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text('Выберите список для просмотра:'),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ListTile(
                    title: Text('Простой список'),
                    onTap: () => _openPage(context, SimpleList()),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Бесконечный список'),
                    onTap: () => _openPage(context, InfinityList()),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Степени числа 2'),
                    onTap: () => _openPage(context, InfinityMathList()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
