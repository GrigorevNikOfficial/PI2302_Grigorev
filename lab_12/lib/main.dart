import 'package:flutter/material.dart';

import 'coffee_machine/coffee.dart';
import 'coffee_machine/enums.dart';
import 'coffee_machine/i_coffee.dart';
import 'coffee_machine/machine.dart';
import 'coffee_machine/resources.dart';
import 'pages/coffee_page.dart';
import 'pages/resources_page.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const CoffeeApp());
}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Machine',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.appBar),
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const CoffeeHome(),
    );
  }
}

class CoffeeHome extends StatefulWidget {
  const CoffeeHome({super.key});

  @override
  State<CoffeeHome> createState() => _CoffeeHomeState();
}

class _CoffeeHomeState extends State<CoffeeHome> {
  late final Machine _machine;
  CoffeeType _selectedType = CoffeeType.espresso;
  int _userMoney = 0;
  bool _isBrewing = false;
  final int _initialCoffeeBeans = 250;
  final int _initialMilk = 250;
  final int _initialWater = 250;
  final int _initialCash = 0;

  @override
  void initState() {
    super.initState();
    _machine = Machine(
      Resources(
        coffeeBeans: _initialCoffeeBeans,
        milk: _initialMilk,
        water: _initialWater,
        cash: _initialCash,
      ),
    );
  }

  ICoffee _recipeForType(CoffeeType type) {
    switch (type) {
      case CoffeeType.espresso:
        return const Espresso();
      case CoffeeType.cappuccino:
        return const Cappuccino();
      case CoffeeType.americano:
        return const Americano();
    }
  }

  void _showSnack(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
      );
  }

  Future<void> _brewCoffee(BuildContext context) async {
    if (_isBrewing) {
      return;
    }

    final recipe = _recipeForType(_selectedType);
    if (_userMoney < recipe.cash()) {
      _showSnack(context, 'Not enough money.');
      return;
    }

    if (!_machine.isAvailableResources(recipe)) {
      _showSnack(context, 'Not enough resources.');
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _isBrewing = true;
    });

    final dialog = showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const _BrewingDialog(),
    );

    final ok = await _machine.makeCoffee(recipe);
    if (!mounted) {
      return;
    }

    Navigator.of(context, rootNavigator: true).pop();
    await dialog;

    setState(() {
      if (ok) {
        _userMoney -= recipe.cash();
      }
      _isBrewing = false;
    });

    _showSnack(context, ok ? 'Coffee is ready.' : 'Not enough resources.');
  }

  bool _addMoney(BuildContext context, int amount) {
    if (amount <= 0) {
      _showSnack(context, 'Enter a positive amount.');
      return false;
    }

    setState(() {
      _userMoney += amount;
    });

    _showSnack(context, 'Added $amount.');
    return true;
  }

  void _refundMoney(BuildContext context) {
    if (_userMoney == 0) {
      _showSnack(context, 'No money to refund.');
      return;
    }

    final refunded = _userMoney;
    setState(() {
      _userMoney = 0;
    });

    _showSnack(context, 'Refunded $refunded.');
  }

  bool _fillResources(
    BuildContext context, {
    required int coffeeBeans,
    required int milk,
    required int water,
    required int cash,
  }) {
    if (coffeeBeans <= 0 && milk <= 0 && water <= 0 && cash <= 0) {
      _showSnack(context, 'Enter at least one value.');
      return false;
    }

    _machine.fillResources(
      coffeeBeans: coffeeBeans,
      milk: milk,
      water: water,
      cash: cash,
    );

    _showSnack(context, 'Resources updated.');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Coffee Machine'),
          backgroundColor: AppColors.appBar,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.local_cafe)),
              Tab(icon: Icon(Icons.inventory_2)),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              CoffeePage(
                resources: _machine.resources,
                userMoney: _userMoney,
                selectedType: _selectedType,
                isBrewing: _isBrewing,
                onTypeChanged: (type) {
                  setState(() {
                    _selectedType = type;
                  });
                },
                onBrew: _brewCoffee,
                onAddMoney: _addMoney,
                onRefundMoney: _refundMoney,
              ),
              ResourcesPage(
                resources: _machine.resources,
                onFillResources: _fillResources,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrewingDialog extends StatelessWidget {
  const _BrewingDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          SizedBox(width: 12),
          Text('Brewing coffee...'),
        ],
      ),
    );
  }
}
