import 'package:flutter/material.dart';

import '../coffee_machine/resources.dart';
import '../theme/app_colors.dart';
import '../widgets/resource_display.dart';

class ResourcesPage extends StatefulWidget {
  const ResourcesPage({
    super.key,
    required this.resources,
    required this.onFillResources,
  });

  final Resources resources;
  final bool Function(
    BuildContext context, {
    required int coffeeBeans,
    required int milk,
    required int water,
    required int cash,
  }) onFillResources;

  @override
  State<ResourcesPage> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  final TextEditingController _milkController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _beansController = TextEditingController();
  final TextEditingController _cashController = TextEditingController();

  @override
  void dispose() {
    _milkController.dispose();
    _waterController.dispose();
    _beansController.dispose();
    _cashController.dispose();
    super.dispose();
  }

  int _readInt(TextEditingController controller) {
    final value = int.tryParse(controller.text.trim()) ?? 0;
    return value < 0 ? 0 : value;
  }

  Widget _buildField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const UnderlineInputBorder(),
      ),
    );
  }

  void _clearFields() {
    _milkController.clear();
    _waterController.clear();
    _beansController.clear();
    _cashController.clear();
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
              title: 'Resources',
              lines: [
                'Milk: ${resources.milk}',
                'Water: ${resources.water}',
                'Beans: ${resources.coffeeBeans}',
                'Cash: ${resources.cash}',
              ],
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildField(_milkController, 'put milk'),
                  _buildField(_waterController, 'put water'),
                  _buildField(_beansController, 'put beans'),
                  _buildField(_cashController, 'put cash'),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 42,
                        width: 42,
                        child: FilledButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            final updated = widget.onFillResources(
                              context,
                              coffeeBeans: _readInt(_beansController),
                              milk: _readInt(_milkController),
                              water: _readInt(_waterController),
                              cash: _readInt(_cashController),
                            );
                            if (updated) {
                              _clearFields();
                            }
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.actionGreen,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        height: 42,
                        width: 42,
                        child: FilledButton(
                          onPressed: _clearFields,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.actionPink,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Icon(Icons.close),
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
