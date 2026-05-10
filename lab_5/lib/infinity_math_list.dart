import 'package:flutter/material.dart';

import 'dart:math';

class InfinityMathList extends StatelessWidget {
  const InfinityMathList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Список элементов'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return const Divider(height: 1);
          }
          final index = i ~/ 2;
          final value = pow(2, index);
          return ListTile(title: Text('2 ^ $index = ${value.toInt()}'));
        },
      ),
    );
  }
}
