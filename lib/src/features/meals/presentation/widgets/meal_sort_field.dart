import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/meal.dart';
import '../../provider/providers.dart';

class MealSortField extends ConsumerWidget {
  final ValueChanged<String?> onMealSortChanged;
  final Meal? meal;

  MealSortField({
    required this.onMealSortChanged,
    required this.meal,
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
            'Sorte:',
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
            value: viewModel.mealSort != null &&
                    viewModel.mealsData
                        .any((m) => m['name'] == viewModel.mealSort)
                ? viewModel.mealSort
                : null,
            onChanged: onMealSortChanged,
            items:
                viewModel.mealsData.map<DropdownMenuItem<String>>((mealData) {
              return DropdownMenuItem<String>(
                value: mealData['name'],
                child:
                    Text(mealData['name'], style: theme.textTheme.bodyMedium),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
