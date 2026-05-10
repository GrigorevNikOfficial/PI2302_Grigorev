import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Общежития КубГАУ',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: 'Общежития КубГАУ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 27;
  bool _isLiked = false;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    const mainColor = Colors.green;
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        centerTitle: false,
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
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
                          icon: const Icon(Icons.favorite, color: Colors.red),
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
                        Column(
                          children: [
                            Icon(Icons.call, color: mainColor),
                            SizedBox(height: 6),
                            Text(
                              'ПОЗВОНИТЬ',
                              style: TextStyle(color: mainColor),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.near_me, color: mainColor),
                            SizedBox(height: 6),
                            Text('МАРШРУТ', style: TextStyle(color: mainColor)),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.share, color: mainColor),
                            SizedBox(height: 6),
                            Text(
                              'ПОДЕЛИТЬСЯ',
                              style: TextStyle(color: mainColor),
                            ),
                          ],
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
