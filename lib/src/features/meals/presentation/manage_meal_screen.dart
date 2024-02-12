import 'package:cat_cuisine/src/features/meals/presentation/widgets/brand_field.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/date_of_entry_field.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/feeding_quantity_field.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/meal_sort_field.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/quantities_field.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/rating_field.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/time_of_day_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/isar_service.dart';
import '../domain/meal.dart';
import '../provider/providers.dart';

class ManageMealScreen extends ConsumerWidget {
  final Meal? meal;
  final ValueChanged<Meal>? onSubmit;
  final IsarService service;

  const ManageMealScreen({
    required this.service,
    this.meal,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(manageMealProvider(meal));

    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.meal != null
            ? "Mahlzeit aktualisieren"
            : "Mahlzeit hinzufügen"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              children: [
                if (viewModel.meal != null)
                  RatingField(meal: meal), // If updating, place at the top
                DateOfEntryField(
                  onDateChanged: (DateTime? newValue) {
                    viewModel.onDateChanged(newValue);
                  },
                  meal: meal,
                ),
                SizedBox(height: 16),
                TimeOfDayField(
                  onTimeOfDayChanged: (String? newValue) {
                    viewModel.onTimeOfDayChanged(newValue);
                  },
                  meal: meal,
                ),
                SizedBox(height: 16),
                BrandField(
                  onBrandChanged: (String? newValue) {
                    viewModel.onBrandChanged(newValue);
                  },
                  meal: meal,
                ),
                SizedBox(height: 16),
                MealSortField(
                    onMealSortChanged: (String? newValue) {
                      viewModel.onMealSortChanged(newValue);
                    },
                    meal: meal),
                SizedBox(height: 16),
                QuantitiesField(
                  onQuantityChanged: (String? newValue) {
                    viewModel.onQuantityChanged(newValue);
                  },
                  meal: meal,
                ),
                SizedBox(height: 16),
                FeedingQuantityField(
                  onFeedingQuantityChanged: (String? newValue) {
                    viewModel.onFeedingQuantityChanged(newValue);
                  },
                  meal: meal,
                ),
                SizedBox(height: 16),
                if (viewModel.meal == null)
                  RatingField(
                      meal: meal), // If creating new, place at the bottom
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    await viewModel.saveMeal();
                    // Check if the onSubmit callback is provided and call it if it is.
                    if (onSubmit != null) {
                      onSubmit!(viewModel.meal!);
                    }
                    // Close the ManageMealScreen and return to the previous screen (MainScreen).
                    Navigator.pop(context);
                  },
                  child:
                      Text(viewModel.meal != null ? "Update Meal" : "Add Meal"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
