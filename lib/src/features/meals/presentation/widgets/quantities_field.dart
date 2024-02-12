import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/meal.dart';
import '../../provider/providers.dart';

class QuantitiesField extends ConsumerWidget {
  final Meal? meal;
  final ValueChanged<String?> onQuantityChanged;

  QuantitiesField({
    required this.meal,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);

    final viewModel = ref.watch(manageMealProvider(meal));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Packungsgröße:',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onBackground,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: theme.colorScheme.primary),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: SizedBox.shrink(),
            value: viewModel.selectedQuantity != null &&
                    viewModel.selectedQuantity!.isNotEmpty
                ? viewModel.selectedQuantity
                : null,
            onChanged: onQuantityChanged,
            items: viewModel.quantities
                .map<DropdownMenuItem<String>>((String quantity) {
              return DropdownMenuItem<String>(
                value: quantity,
                child: Text(quantity, style: theme.textTheme.bodyMedium),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
