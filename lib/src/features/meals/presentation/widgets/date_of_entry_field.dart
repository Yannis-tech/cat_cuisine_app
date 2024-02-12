import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/meal.dart';
import '../../provider/providers.dart';

class DateOfEntryField extends ConsumerWidget {
  final Meal? meal;
  final ValueChanged<DateTime?> onDateChanged;

  DateOfEntryField({
    required this.meal,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);

    // Access your ViewModel to get the dateOfEntry
    final viewModel = ref.watch(manageMealProvider(meal));

    return InkWell(
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: viewModel.dateOfEntry,
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
        );
        if (selectedDate != null) {
          viewModel.onDateChanged(selectedDate);
        }
      },
      child: ListTile(
        title: Text(
          'Datum: ${DateFormat('dd. MMMM yyyy', 'de_DE').format(viewModel.dateOfEntry)}',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 16.0,
            color: theme.colorScheme.onBackground,
          ),
        ),
        trailing: Icon(
          Icons.calendar_today,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
