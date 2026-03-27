import 'dart:io';
import './classes/Machine.dart';

void main() {

  const int initialCoffeeBeans = 150;
  const int initialMilk = 0;
  const int initialWater = 200;
  const int initialCash = 0;

  Machine machine = Machine(initialCoffeeBeans, initialMilk, initialWater, initialCash);

  while (true) {
    _printMenu();
    String input = stdin.readLineSync() ?? "";
  
    switch (input) {
      case "1":
        _makeCoffeeVariant1(machine);
        break;

      case "2":
        _makeCoffeeVariant2(machine, initialCoffeeBeans, initialWater);
        break;

      case "3":
        print("Выход из программы.");
        return;
        
      default:
        print("Неверная команда. Try again.\n");
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

void _makeCoffeeVariant1(Machine machine) {
  (machine.makingCoffee()) ? print("Кофе готов!\n") : print("Недостаточно ресурсов для приготовления кофе.\n");
}

void _makeCoffeeVariant2(Machine machine, initialCoffeeBeans, initialWater) {
  machine.addResources(initialCoffeeBeans, initialWater);
        print("Ресурсы добавлены. Текущие запасы: ${machine.coffeeBeans} кофе, ${machine.water} воды.\n");
}
