import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор площади',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.blue)),
      home: const MyHomePage(title: 'Калькулятор площади'),
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
  final _formKey = GlobalKey<FormState>();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  String _resultText = 'задайте параметры';

  String? _validateNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Задайте $fieldName';
    }
    if (int.tryParse(value) == null) {
      return '$fieldName должно быть числом';
    }
    return null;
  }

  void _calculateArea() {
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }

    final width = int.parse(_widthController.text);
    final height = int.parse(_heightController.text);
    final area = width * height;

    setState(() {
      _resultText = 'S = $width * $height = $area (мм2)';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Вычисление выполнено'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _widthController,
                  decoration: InputDecoration(labelText: 'Ширина (мм):'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) => _validateNumber(value, 'Ширину'),
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: _heightController,
                  decoration: InputDecoration(labelText: 'Высота (мм):'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) => _validateNumber(value, 'Высоту'),
                ),
                SizedBox(height: 12.0),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _calculateArea,
                    child: Text('Вычислить'),
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: Text(_resultText, style: TextStyle(fontSize: 22.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
