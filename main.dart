import 'dart:io';
import './classes/Enums.dart';
import './classes/Machine.dart';
import './classes/Resources.dart';

Future<void> main() async {
  const int initialCoffeeBeans = 150;
  const int initialMilk = 100;
  const int initialWater = 200;
  const int initialCash = 0;

  final machine = Machine(
    Resources(
      coffeeBeans: initialCoffeeBeans,
      milk: initialMilk,
      water: initialWater,
      cash: initialCash,
    ),
  );

  while (true) {
    _printMenu();
    final input = stdin.readLineSync()?.trim() ?? "";

    switch (input) {
      case "1":
        await _makeCoffee(machine);
        break;

      case "2":
        _fillResources(machine);
        break;

      case "3":
        print("Выход из программы.");
        return;

      default:
        print("Невозможное действие. Try again.\n");
    }
  }
}

void _printMenu() {
  print('Доступные команды:');
  print('1. Сделать кофе');
  print('2. Добавить ресурсы');
  print('3. Выйти');
  stdout.write('Введите номер команды: ');
}

Future<void> _makeCoffee(Machine machine) async {
  final type = _readCoffeeType();
  if (type == null) {
    print("Неверный выбор.\n");
    return;
  }

  final isMade = await machine.makeCoffeeByType(type);
  if (isMade) {
    print("Кофе готов!\n");
  } else {
    print("Недостаточно ресурсов для приготовления кофе.\n");
  }
}

CoffeeType? _readCoffeeType() {
  print('Выберите вариант кофе:');
  print('1. Эспрессо');
  print('2. Капучино');
  print('3. Американо');
  stdout.write('Введите номер варианта: ');

  final input = stdin.readLineSync()?.trim() ?? '';
  switch (input) {
    case '1':
      return CoffeeType.espresso;
    case '2':
      return CoffeeType.cappuccino;
    case '3':
      return CoffeeType.americano;
    default:
      return null;
  }
}

void _fillResources(Machine machine) {
  final coffeeBeans = _readInt('Введите количество кофе: ');
  final milk = _readInt('Введите количество молока: ');
  final water = _readInt('Введите количество воды: ');

  machine.fillResources(coffeeBeans: coffeeBeans, milk: milk, water: water);

  final resources = machine.resources;
  print(
    "Ресурсы добавлены. Текущие запасы: ${resources.coffeeBeans} кофе, "
    "${resources.milk} молока, ${resources.water} воды, ${resources.cash} денег.\n",
  );
}

int _readInt(String prompt) {
  stdout.write(prompt);
  final input = stdin.readLineSync()?.trim() ?? '';
  return int.tryParse(input) ?? 0;
}
