import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateOfEntryField extends StatefulWidget {
  final DateTime dateOfEntry;
  final ValueChanged<DateTime?> onDateChanged;

  DateOfEntryField({
    required this.dateOfEntry,
    required this.onDateChanged,
  });

  @override
  _DateOfEntryFieldState createState() => _DateOfEntryFieldState();
}

class _DateOfEntryFieldState extends State<DateOfEntryField> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return InkWell(
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: widget.dateOfEntry,
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
        );
        if (selectedDate != null) {
          widget.onDateChanged(selectedDate);
        }
      },
      child: ListTile(
        title: Text(
          'Datum: ${DateFormat('dd. MMMM yyyy', 'de_DE').format(widget.dateOfEntry)}',
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
