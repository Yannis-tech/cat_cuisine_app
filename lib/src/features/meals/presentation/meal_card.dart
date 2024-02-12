import 'package:cat_cuisine/src/features/meals/domain/meal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../domain/rating.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;
  final List<Rating> ratings; // New parameter to accept list of ratings

  MealCard({required this.meal, required this.onTap, required this.ratings});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd. MMMM yyyy');

    int? lowestRating = ratings.isEmpty
        ? null
        : ratings
            .map((rating) => rating.mealRating)
            .reduce((value, element) => value! < element! ? value : element);

    return InkWell(
      onTap: onTap,
      child: Card(
        color: theme.colorScheme.primaryContainer,
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
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: theme.colorScheme.onPrimaryContainer),
                  ),
                  if (lowestRating != null)
                    Icon(
                      lowestRating == 1
                          ? Icons.sentiment_very_dissatisfied // bad rating
                          : lowestRating <= 3
                              ? Icons.sentiment_neutral // ok rating
                              : Icons.sentiment_very_satisfied, // good rating
                      color: lowestRating == 1
                          ? Colors.red
                          : lowestRating <= 3
                              ? Colors.orange
                              : Colors.green,
                    ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                meal.brand ?? '',
                style: theme.textTheme.labelLarge
                    ?.copyWith(color: theme.colorScheme.onSurface),
              ),
              Text(
                meal.mealSort ?? '',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.onSurface),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  meal.timeOfDay ?? '',
                  style: theme.textTheme.titleSmall
                      ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
