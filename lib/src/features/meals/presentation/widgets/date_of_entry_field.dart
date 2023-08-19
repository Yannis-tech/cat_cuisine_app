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
    return ListTile(
      title: Text(
        'Datum: ${DateFormat('dd. MMMM yyyy', 'de_DE').format(widget.dateOfEntry)}',
        style: TextStyle(fontSize: 16.0),
      ),
      trailing: IconButton(
        icon: Icon(Icons.calendar_today),
        onPressed: () async {
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
      ),
    );
  }
}
