Future<void> heatWater() async {
  print('Нагрев воды...');
  await Future.delayed(Duration(seconds: 3));
  print('Вода нагрета.');
}

Future<void> brewCoffee() async {
  print('Заваривание кофе...');
  await Future.delayed(Duration(seconds: 5));
  print('Кофе заварено.');
}

Future<void> frothMilk() async {
  print('Взбивание молока...');
  await Future.delayed(Duration(seconds: 5));
  print('Молоко взбито.');
}

Future<void> mixCoffeeAndMilk() async {
  print('Смешивание кофе и молока...');
  await Future.delayed(Duration(seconds: 3));
  print('Кофе с молоком готово.');
}

Future<void> prepareCoffee({required bool withMilk}) async {
  await heatWater();

  final brewFuture = brewCoffee();
  if (withMilk) {
    final frothFuture = frothMilk();
    await Future.wait([brewFuture, frothFuture]);
    await mixCoffeeAndMilk();
  } else {
    await brewFuture;
  }
}

class CoffeeProcess {
  final Future<void> done;

  CoffeeProcess._(this.done);

  factory CoffeeProcess.start({required bool withMilk}) {
    final done = prepareCoffee(withMilk: withMilk);
    return CoffeeProcess._(done);
  }
}
