import 'package:flutter/material.dart';

class MealSortField extends StatelessWidget {
  final String mealSort;
  final List<dynamic> meals;
  final ValueChanged<String?> onMealSortChanged;

  MealSortField({
    required this.mealSort,
    required this.meals,
    required this.onMealSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

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
            value:
                mealSort.isNotEmpty && meals.any((m) => m['name'] == mealSort)
                    ? mealSort
                    : null,
            onChanged: onMealSortChanged,
            items: meals.map<DropdownMenuItem<String>>((mealData) {
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
