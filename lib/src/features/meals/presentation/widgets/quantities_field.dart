import 'package:flutter/material.dart';

class QuantitiesField extends StatelessWidget {
  final String selectedQuantity;
  final List<String> quantities;
  final ValueChanged<String?> onQuantityChanged;

  QuantitiesField({
    required this.selectedQuantity,
    required this.quantities,
    required this.onQuantityChanged,
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
            'Packungsgröße:',
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
            value: selectedQuantity.isEmpty ? null : selectedQuantity,
            onChanged: onQuantityChanged,
            items: quantities.map<DropdownMenuItem<String>>((String quantity) {
              return DropdownMenuItem<String>(
                value: quantity,
                child: Text(quantity, style: theme.textTheme.bodyMedium),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
