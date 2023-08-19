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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Tageszeit:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        DropdownButton<String>(
          isExpanded: true,
          value: timeOfDay,
          onChanged: (String? newValue) {
            onTimeOfDayChanged(newValue ?? timeOfDay);
          },
          items: [
            DropdownMenuItem<String>(
              value: 'Morgens',
              child: Text('Morgens'),
            ),
            DropdownMenuItem<String>(
              value: 'Nachmittags',
              child: Text('Nachmittags'),
            ),
            DropdownMenuItem<String>(
              value: 'Abends',
              child: Text('Abends'),
            ),
          ],
        ),
      ],
    );
  }
}
