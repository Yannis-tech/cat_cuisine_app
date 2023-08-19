import 'package:cat_cuisine/src/features/meals/domain/meal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;

  MealCard({required this.meal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd. MMMM yyyy');

    return InkWell(
      onTap: onTap,
      child: Card(
        color: theme.colorScheme.primaryContainer, // Using the surface color
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    meal.dateOfEntry != null
                        ? dateFormat.format(meal.dateOfEntry!.toLocal())
                        : '',
                    style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme
                            .onPrimaryContainer), // Using headline6 style
                  ),
                  Text(
                    meal.timeOfDay ?? '',
                    style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme
                            .onSurfaceVariant), // Using bodyText1 style
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                meal.brand ?? '',
                style: theme.textTheme.labelLarge?.copyWith(
                    color:
                        theme.colorScheme.onSurface), // Using bodyText2 style
              ),
              Text(
                meal.mealSort ?? '',
                style: theme.textTheme.bodyMedium?.copyWith(
                    color:
                        theme.colorScheme.onSurface), // Using bodyText2 style
              ),
            ],
          ),
        ),
      ),
    );
  }
}
