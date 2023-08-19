import 'package:flutter/material.dart';

class FeedingQuantityField extends StatelessWidget {
  final String feedingQuantity;
  final ValueChanged<String?> onChanged;

  FeedingQuantityField({
    required this.feedingQuantity,
    required this.onChanged,
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
            value: feedingQuantity.isNotEmpty ? feedingQuantity : null,
            onChanged: onChanged,
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
