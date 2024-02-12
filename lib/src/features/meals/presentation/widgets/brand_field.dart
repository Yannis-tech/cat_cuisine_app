import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/meal.dart';
import '../../provider/providers.dart';

class BrandField extends ConsumerWidget {
  final ValueChanged<String?> onBrandChanged;
  final Meal? meal;

  BrandField({
    required this.onBrandChanged,
    required this.meal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);

    // Read values from your ViewModel provider
    final viewModel = ref.watch(manageMealProvider(meal));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Marke:',
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
            value: viewModel.brand.isNotEmpty &&
                    viewModel.brandsData
                        .any((b) => b['name'] == viewModel.brand)
                ? viewModel.brand
                : null,
            onChanged: (String? newValue) {
              onBrandChanged(newValue);
            },
            items:
                viewModel.brandsData.map<DropdownMenuItem<String>>((brandData) {
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
