import 'package:flutter/material.dart';

class SimpleList extends StatelessWidget {
  const SimpleList({super.key});

  @override
  Widget build(BuildContext context) {
    const items = ['0000', '0001', '0010'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Список элементов'),
        centerTitle: false,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (context, index) => Divider(height: 1),
        itemBuilder: (context, index) => ListTile(title: Text(items[index])),
      ),
    );
  }
}
