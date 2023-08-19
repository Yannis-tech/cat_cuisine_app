import 'package:flutter/material.dart';

class BrandField extends StatelessWidget {
  final String brand;
  final List<Map<String, dynamic>> brands;
  final ValueChanged<String?> onBrandChanged;

  BrandField({
    required this.brand,
    required this.brands,
    required this.onBrandChanged,
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
            'Marke:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            value: brand.isNotEmpty && brands.any((b) => b['name'] == brand)
                ? brand
                : null,
            onChanged: (String? newValue) {
              onBrandChanged(newValue);
            },
            items: brands.map<DropdownMenuItem<String>>((brandData) {
              return DropdownMenuItem<String>(
                value: brandData['name'],
                child:
                    Text(brandData['name'], style: theme.textTheme.bodyMedium),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
