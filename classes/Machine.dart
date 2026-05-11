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

  bool makeCoffee(ICoffee coffee) {
    if (!isAvailableResources(coffee)) {
      return false;
    }

    _resources.coffeeBeans -= coffee.coffeeBeans();
    _resources.milk -= coffee.milk();
    _resources.water -= coffee.water();
    _resources.cash += coffee.cash();
    return true;
  }

  bool makeCoffeeByType(CoffeeType type) {
    final coffee = _coffeeByType(type);
    return makeCoffee(coffee);
  }

  ICoffee _coffeeByType(CoffeeType type) {
    switch (type) {
      case CoffeeType.espresso:
        return Espresso();
      case CoffeeType.cappuccino:
        return Cappuccino();
      case CoffeeType.americano:
        return Americano();
    }
  }
}
