import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/meal.dart';
import '../../provider/providers.dart';

class RatingField extends ConsumerWidget {
  final Meal? meal;

  RatingField({
    this.meal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);
    final viewModel = ref.watch(manageMealProvider(meal));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: viewModel.ratings.keys.map((cat) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                '${cat.name}:',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ),
            Slider(
              value: viewModel.ratings[cat]!.mealRating!.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: (double newValue) {
                viewModel.onRatingChanged(
                    cat, newValue.toInt()); // Use method from ViewModel
              },
              label:
                  '${viewModel.ratings[cat]?.mealRating}', // Use mealRating property here
            ),
          ],
        );
      }).toList(),
    );
  }
}
