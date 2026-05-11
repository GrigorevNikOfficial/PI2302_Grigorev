Future<void> heatWater() async {
  await Future.delayed(const Duration(seconds: 3));
}

Future<void> brewCoffee() async {
  await Future.delayed(const Duration(seconds: 5));
}

Future<void> frothMilk() async {
  await Future.delayed(const Duration(seconds: 5));
}

Future<void> mixCoffeeAndMilk() async {
  await Future.delayed(const Duration(seconds: 3));
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
