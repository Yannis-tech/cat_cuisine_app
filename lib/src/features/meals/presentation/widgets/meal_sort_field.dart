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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Sorte:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        DropdownButton<String>(
          isExpanded: true,
          value: mealSort.isNotEmpty && meals.any((m) => m['name'] == mealSort)
              ? mealSort
              : null,
          onChanged: onMealSortChanged,
          items: meals.map<DropdownMenuItem<String>>((mealData) {
            return DropdownMenuItem<String>(
              value: mealData['name'],
              child: Text(mealData['name']),
            );
          }).toList(),
        ),
      ],
    );
  }
}
