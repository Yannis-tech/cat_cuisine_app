import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/meal.dart';
import '../../provider/providers.dart';

class FeedingQuantityField extends ConsumerWidget {
  final Meal? meal;
  final ValueChanged<String?> onFeedingQuantityChanged;

  FeedingQuantityField({
    required this.meal,
    required this.onFeedingQuantityChanged,
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
            'Fütterungsmenge:',
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
            value: viewModel.feedingQuantity.isNotEmpty
                ? viewModel.feedingQuantity
                : null,
            onChanged: onFeedingQuantityChanged,
            items: [
              DropdownMenuItem<String>(
                value: 'halbe-halbe',
                child: Text('halbe-halbe', style: theme.textTheme.bodyMedium),
              ),
              DropdownMenuItem<String>(
                value: 'Je eine Packung',
                child:
                    Text('Je eine Packung', style: theme.textTheme.bodyMedium),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
