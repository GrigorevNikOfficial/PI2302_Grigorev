import 'dart:io';
import './classes/Machine.dart';

void main() {

  const int initialCoffeeBeans = 150;
  const int initialMilk = 0;
  const int initialWater = 200;
  const int initialCash = 0;

  Machine machine = Machine(initialCoffeeBeans, initialMilk, initialWater, initialCash);

  while (true) {
    print("Доступные команды:");

    print("1. Сделать кофе");
    print("2. Добавить ресурсы");
    print("3. Выйти");

    stdout.write("Введите номер команды: ");

    String input = stdin.readLineSync() ?? "";
  
    switch (input) {
      case "1":
        if (machine.makingCoffee()) {
          print("Кофе готов!\n");
        } else {
          print("Недостаточно ресурсов для приготовления кофе.\n");
        }
        break;

      case "2":
        machine.coffeeBeans += initialCoffeeBeans;
        machine.water += initialWater;
        print("Ресурсы добавлены. Текущие запасы: ${machine.coffeeBeans} кофе, ${machine.water} воды.\n");
        break;

      case "3":
        print("Выход из программы.");
        return;
        
      default:
        print("Неверная команда. Try again.\n");
    }
  }

}
