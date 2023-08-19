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
        DropdownButton<String>(
          isExpanded: true,
          value: brand.isNotEmpty && brands.any((b) => b['name'] == brand)
              ? brand
              : null,
          onChanged: (String? newValue) {
            onBrandChanged(newValue);
          },
          items: brands.map<DropdownMenuItem<String>>((brandData) {
            return DropdownMenuItem<String>(
              value: brandData['name'],
              child: Text(brandData['name']),
            );
          }).toList(),
        ),
      ],
    );
  }
}
