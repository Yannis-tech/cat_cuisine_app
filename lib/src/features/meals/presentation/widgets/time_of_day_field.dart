import 'package:flutter/material.dart';

class TimeOfDayField extends StatelessWidget {
  final String timeOfDay;
  final ValueChanged<String?> onTimeOfDayChanged;

  TimeOfDayField({
    required this.timeOfDay,
    required this.onTimeOfDayChanged,
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
            'Tageszeit:',
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
            underline: SizedBox.shrink(), // Remove default underline
            value: timeOfDay,
            onChanged: (String? newValue) {
              onTimeOfDayChanged(newValue ?? timeOfDay);
            },
            items: [
              DropdownMenuItem<String>(
                value: 'Morgens',
                child: Text('Morgens', style: theme.textTheme.bodyMedium),
              ),
              DropdownMenuItem<String>(
                value: 'Nachmittags',
                child: Text('Nachmittags', style: theme.textTheme.bodyMedium),
              ),
              DropdownMenuItem<String>(
                value: 'Abends',
                child: Text('Abends', style: theme.textTheme.bodyMedium),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
