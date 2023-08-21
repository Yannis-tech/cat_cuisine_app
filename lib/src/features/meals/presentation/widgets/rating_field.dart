import 'package:flutter/material.dart';
import 'package:cat_cuisine/src/features/meals/domain/cat.dart';

typedef RatingChangedCallback = void Function(Cat cat, int rating);

class RatingField extends StatelessWidget {
  final List<Cat> cats;
  final Map<Cat, int> ratings;
  final RatingChangedCallback onRatingChanged;

  RatingField({
    required this.cats,
    required this.ratings,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cats.map((cat) {
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
              value: ratings[cat]?.toDouble() ?? 0,
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: (double newValue) {
                onRatingChanged(cat, newValue.toInt());
              },
              label: '${ratings[cat]}',
            ),
          ],
        );
      }).toList(),
    );
  }
}
