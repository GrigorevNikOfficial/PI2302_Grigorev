import 'package:flutter/material.dart';

import '../coffee_machine/enums.dart';
import '../coffee_machine/resources.dart';
import '../theme/app_colors.dart';
import '../widgets/resource_display.dart';

class CoffeePage extends StatefulWidget {
  const CoffeePage({
    super.key,
    required this.resources,
    required this.userMoney,
    required this.selectedType,
    required this.isBrewing,
    required this.onTypeChanged,
    required this.onBrew,
    required this.onAddMoney,
    required this.onRefundMoney,
  });

  final Resources resources;
  final int userMoney;
  final CoffeeType selectedType;
  final bool isBrewing;
  final ValueChanged<CoffeeType> onTypeChanged;
  final Future<void> Function(BuildContext context) onBrew;
  final bool Function(BuildContext context, int amount) onAddMoney;
  final void Function(BuildContext context) onRefundMoney;

  @override
  State<CoffeePage> createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  final TextEditingController _moneyController = TextEditingController();

  @override
  void dispose() {
    _moneyController.dispose();
    super.dispose();
  }

  int _readMoney() {
    final value = int.tryParse(_moneyController.text.trim()) ?? 0;
    return value < 0 ? 0 : value;
  }

  Widget _buildRadio(CoffeeType type, String label) {
    return RadioListTile<CoffeeType>(
      value: type,
      groupValue: widget.selectedType,
      onChanged: (value) {
        if (value != null) {
          widget.onTypeChanged(value);
        }
      },
      title: Text(label),
      dense: true,
      contentPadding: EdgeInsets.zero,
      activeColor: AppColors.actionTeal,
    );
  }

  @override
  Widget build(BuildContext context) {
    final resources = widget.resources;

    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            color: AppColors.displayPanel,
            padding: const EdgeInsets.all(16),
            child: ResourceDisplay(
              title: 'Coffee Maker',
              lines: [
                'Beans: ${resources.coffeeBeans}',
                'Milk: ${resources.milk}',
                'Water: ${resources.water}',
              ],
              footer: 'Your money: ${widget.userMoney}',
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            color: AppColors.panelBackground,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  _buildRadio(CoffeeType.espresso, 'espresso'),
                  _buildRadio(CoffeeType.cappuccino, 'cappuccino'),
                  _buildRadio(CoffeeType.americano, 'americano'),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 44,
                      width: 44,
                      child: FilledButton(
                        onPressed: widget.isBrewing
                            ? null
                            : () => widget.onBrew(context),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.actionTeal,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Icon(Icons.play_arrow),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _moneyController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Put money here',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 42,
                        width: 42,
                        child: FilledButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            final amount = _readMoney();
                            final added = widget.onAddMoney(context, amount);
                            if (added) {
                              _moneyController.clear();
                            }
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.actionGreen,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Icon(Icons.attach_money),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 42,
                        width: 42,
                        child: FilledButton(
                          onPressed: () => widget.onRefundMoney(context),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.actionPink,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Icon(Icons.money_off),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
