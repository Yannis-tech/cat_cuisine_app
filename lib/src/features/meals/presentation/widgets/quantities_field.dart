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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Packungsgröße:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        DropdownButton<String>(
          isExpanded: true,
          value: selectedQuantity,
          onChanged: onQuantityChanged,
          items: (quantities.length == 1 && quantities[0] == selectedQuantity
                  ? quantities
                  : (quantities.toSet()..add(selectedQuantity)).toList())
              .map<DropdownMenuItem<String>>((quantity) {
            return DropdownMenuItem<String>(
              value: quantity,
              child: Text(quantity),
            );
          }).toList(),
        ),
      ],
    );
  }
}
