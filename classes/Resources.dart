class Resources {
  int _coffeeBeans;
  int _milk;
  int _water;
  int _cash;

  Resources({
    required int coffeeBeans,
    required int milk,
    required int water,
    required int cash,
  }) : _coffeeBeans = coffeeBeans,
       _milk = milk,
       _water = water,
       _cash = cash;

  int get coffeeBeans => _coffeeBeans;
  set coffeeBeans(int value) => _coffeeBeans = value;

  int get milk => _milk;
  set milk(int value) => _milk = value;

  int get water => _water;
  set water(int value) => _water = value;

  int get cash => _cash;
  set cash(int value) => _cash = value;
}
