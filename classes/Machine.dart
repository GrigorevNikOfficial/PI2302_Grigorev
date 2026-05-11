import './AsyncMethods.dart';
import './Coffee.dart';
import './Enums.dart';
import './ICoffee.dart';
import './Resources.dart';

class Machine {
  final Resources _resources;

  Machine(this._resources);

  Resources get resources => _resources;

  void fillResources({
    int coffeeBeans = 0,
    int milk = 0,
    int water = 0,
    int cash = 0,
  }) {
    _resources.add(
      coffeeBeans: coffeeBeans,
      milk: milk,
      water: water,
      cash: cash,
    );
  }

  bool isAvailableResources(ICoffee coffee) {
    return _resources.coffeeBeans >= coffee.coffeeBeans() &&
        _resources.milk >= coffee.milk() &&
        _resources.water >= coffee.water();
  }

  Future<bool> makeCoffee(ICoffee coffee) async {
    if (!isAvailableResources(coffee)) {
      return false;
    }

    _resources.coffeeBeans -= coffee.coffeeBeans();
    _resources.milk -= coffee.milk();
    _resources.water -= coffee.water();

    final process = CoffeeProcess.start(withMilk: coffee.milk() > 0);
    await process.done;

    _resources.cash += coffee.cash();
    return true;
  }

  Future<bool> makeCoffeeByType(CoffeeType type) {
    final coffee = _coffeeByType(type);
    return makeCoffee(coffee);
  }

  ICoffee _coffeeByType(CoffeeType type) {
    switch (type) {
      case CoffeeType.espresso:
        return const Espresso();
      case CoffeeType.cappuccino:
        return const Cappuccino();
      case CoffeeType.americano:
        return const Americano();
    }
  }
}
