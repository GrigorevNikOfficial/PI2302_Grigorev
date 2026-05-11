import 'i_coffee.dart';

class Cappuccino implements ICoffee {
  const Cappuccino();

  @override
  int coffeeBeans() => 50;

  @override
  int milk() => 100;

  @override
  int water() => 100;

  @override
  int cash() => 150;
}

class Espresso implements ICoffee {
  const Espresso();

  @override
  int coffeeBeans() => 50;

  @override
  int milk() => 0;

  @override
  int water() => 100;

  @override
  int cash() => 100;
}

class Americano implements ICoffee {
  const Americano();

  @override
  int coffeeBeans() => 50;

  @override
  int milk() => 0;

  @override
  int water() => 150;

  @override
  int cash() => 120;
}
