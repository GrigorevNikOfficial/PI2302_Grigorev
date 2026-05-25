import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Общежития КубГАУ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: 'Общежития КубГАУ'),
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
  int _counter = 27;
  bool _isLiked = false;

  Future<void> _makeCall() async {
    const phone = '+79180000000';
    final uri = Uri(scheme: 'tel', path: phone);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _openRoute() async {
    final uri = Uri.https('www.google.com', '/maps/dir/', {
      'api': '1',
      'destination': 'Краснодар, ул. Калинина, 13',
    });
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _shareInfo(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final origin = box == null
        ? null
        : box.localToGlobal(Offset.zero) & box.size;
    await Share.share(
      'Общежитие №20, Краснодар, ул. Калинина, 13',
      sharePositionOrigin: origin,
    );
  }

  void _incrementCounter() {
    setState(() {
      if (_isLiked) {
        _counter = 27;
        _isLiked = false;
      } else {
        _counter = 28;
        _isLiked = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const mainColor = Colors.green;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: mainColor,
        foregroundColor: Colors.white,

        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              Image.asset('src/dorm.jpeg', height: 240, fit: BoxFit.cover),
              Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Общежитие №20',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Краснодар, ул. Калинина, 13',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: _incrementCounter,
                          icon: Icon(
                            Icons.favorite,
                            color: _isLiked ? Colors.red : Colors.grey,
                          ),
                          tooltip: 'Лайк',
                        ),
                        Text(
                          '$_counter',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: _makeCall,
                          style: TextButton.styleFrom(
                            foregroundColor: mainColor,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.call),
                              SizedBox(height: 6),
                              Text('ПОЗВОНИТЬ', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: _openRoute,
                          style: TextButton.styleFrom(
                            foregroundColor: mainColor,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.near_me),
                              SizedBox(height: 6),
                              Text('МАРШРУТ', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                        Builder(
                          builder: (context) => TextButton(
                            onPressed: () => _shareInfo(context),
                            style: TextButton.styleFrom(
                              foregroundColor: mainColor,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.share),
                                SizedBox(height: 6),
                                Text(
                                  'ПОДЕЛИТЬСЯ',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Студенческий городок или так называемый кампус '
                      'Кубанского ГАУ состоит из двадцати общежитий, в которых '
                      'проживает более 8000 студентов, что составляет 96% от '
                      'всех нуждающихся. Студенты первого курса обеспечены '
                      'местами в общежитии полностью. В соответствии с '
                      'Положением о студенческих общежитиях университета, при '
                      'поселении между администрацией и студентами заключается '
                      'договор найма жилого помещения. Воспитательная работа в '
                      'общежитиях направлена на улучшение быта, соблюдение '
                      'правил внутреннего распорядка, отсутствия асоциальных '
                      'явлений в молодежной среде. Условия проживания в '
                      'общежитиях университетского кампуса полностью отвечают '
                      'санитарным нормам и требованиям: наличие оборудованных '
                      'кухонь, душевых комнат, прачечных, читальных залов, '
                      'комнат самоподготовки, помещений для заседаний '
                      'студенческих советов и наглядной агитации. С целью '
                      'улучшения условий быта студентов активно работает '
                      'система студенческого самоуправления - студенческие '
                      'советы организуют всю работу по самообслуживанию.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
