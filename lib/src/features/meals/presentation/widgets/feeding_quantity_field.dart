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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Fütterungsmenge:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        DropdownButton<String>(
          isExpanded: true,
          value: feedingQuantity.isNotEmpty ? feedingQuantity : null,
          onChanged: onChanged,
          items: [
            DropdownMenuItem<String>(
              value: 'halbe-halbe',
              child: Text('halbe-halbe'),
            ),
            DropdownMenuItem<String>(
              value: 'Je eine Packung',
              child: Text('Je eine Packung'),
            ),
          ],
        ),
      ],
    );
  }
}
