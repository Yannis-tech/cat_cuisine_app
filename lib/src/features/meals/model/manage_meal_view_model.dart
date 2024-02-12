import 'package:cat_cuisine/src/features/meals/data/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../domain/cat.dart';
import '../data/data_utils.dart' as data_utils;
import '../domain/meal.dart';
import '../domain/rating.dart';

class ManageMealViewModel extends ChangeNotifier {
  final IsarService service;
  final Meal? meal;
  final ValueChanged<Meal>? onSubmit;

  DateTime dateOfEntry = DateTime.now();
  String timeOfDay = 'Morgens';
  String brand = '';
  String? mealSort;
  List<String> quantities = [];
  String? selectedQuantity;
  String feedingQuantity = 'halbe-halbe';
  Map<Cat, Rating> ratings = {};

  // Brands and meals
  List<dynamic> mealsData = [];
  List<Map<String, dynamic>> brandsData = [];

  // form validation
  final formKey = GlobalKey<FormState>();

  ManageMealViewModel(this.service, {this.meal, this.onSubmit}) {
    if (meal != null) {
      _loadExistingMealData();
      _loadExistingRatingData();
    } else {
      dateOfEntry = DateTime.now();
      timeOfDay = 'Morgens';
      brand = '';
      mealSort = null;
      selectedQuantity = null;
    }
    loadBrands().then((_) {
      if (meal == null) {
        // Only set default values if it's a new meal
        brand = brandsData.firstOrNull?['name'] ?? '';
        updateMealsData();
        mealSort = mealsData.firstOrNull?['name'];
        updateQuantities(brandsData);
        selectedQuantity = quantities.firstOrNull;
        _loadExistingRatingData();
      }
    });
  }

  Future<void> _loadExistingMealData() async {
    dateOfEntry = meal!.dateOfEntry ?? DateTime.now();
    timeOfDay = meal!.timeOfDay ?? 'Morgens';
    brand = meal!.brand ?? '';
    mealSort = meal!.mealSort;
    selectedQuantity = meal!.quantities?.firstOrNull;
    feedingQuantity = meal!.feedingQuantity ?? 'halbe-halbe';

    // Initialize mealsData and quantities based on the loaded meal data
    await loadBrands();
    updateMealsData();
    updateQuantities(brandsData);

    notifyListeners();
  }

  Future<void> _loadExistingRatingData() async {
    List<Cat> cats = await service.getAllCats();
    List<Rating> ratingsList =
        meal != null ? await service.getRatingsForMeal(meal!) : [];
    for (final cat in cats) {
      final ratingForCat = ratingsList
          .firstWhereOrNull((rating) => rating.cat.value?.id == cat.id);
      if (ratingForCat != null) {
        ratings[cat] = ratingForCat; // Store the existing Rating object
      } else {
        ratings[cat] = Rating()
          ..cat.value = cat
          ..mealRating = 3; // Initialize mealRating to a default value
      }
    }
    notifyListeners();
  }

  void onDateChanged(DateTime? newDate) {
    dateOfEntry = newDate ?? dateOfEntry;
    notifyListeners();
  }

  void onTimeOfDayChanged(String? newValue) {
    timeOfDay = newValue ?? timeOfDay;
    notifyListeners();
  }

  void onBrandChanged(String? newValue) {
    if (newValue != null) {
      brand = newValue;
      updateMealsData();
      notifyListeners();
    }
  }

  void onMealSortChanged(String? newValue) {
    if (newValue != null) {
      mealSort = newValue;
      updateQuantities(brandsData);
      notifyListeners();
    }
  }

  void onQuantityChanged(String? newValue) {
    if (newValue != null) {
      selectedQuantity = newValue;
      notifyListeners();
    }
  }

  void onFeedingQuantityChanged(String? newValue) {
    if (newValue != null) {
      feedingQuantity = newValue;
      notifyListeners();
    }
  }

  void onRatingChanged(Cat cat, int ratingValue) {
    if (ratings[cat] != null) {
      ratings[cat]!.mealRating =
          ratingValue; // Update the mealRating property of the existing Rating object
    }
    notifyListeners();
  }

  Future<void> loadBrands() async {
    try {
      brandsData = await data_utils.loadBrands();
      notifyListeners();
    } catch (e) {
      // Handle any errors that occur during the fetch operation
      print('Error loading brands: $e');
    }
  }

  void updateMealsData() {
    if (brand.isNotEmpty) {
      final brandData = brandsData
          .firstWhere((brand) => brand['name'] == this.brand, orElse: () => {});
      mealsData = brandData['meals'] as List<dynamic>? ?? [];
      notifyListeners();
    }
  }

  void updateQuantities(List<Map<String, dynamic>> brandsData) {
    if (brand.isNotEmpty && mealSort != null) {
      final brandData =
          brandsData.firstWhere((brand) => brand['name'] == this.brand);
      final mealData = (brandData['meals'] as List<dynamic>?)
          ?.firstWhere((meal) => meal['name'] == mealSort, orElse: () => {});
      quantities = List<String>.from(mealData?['quantities'] ?? []);
      if (!quantities.contains(selectedQuantity)) {
        selectedQuantity = quantities.firstOrNull;
      }
      notifyListeners();
    }
  }

  Future<void> saveMeal() async {
    if (formKey.currentState!.validate()) {
      final mealToSubmit = (meal ?? Meal())
        ..dateOfEntry = dateOfEntry
        ..timeOfDay = timeOfDay
        ..brand = brand
        ..mealSort = mealSort
        ..quantities = selectedQuantity != null ? [selectedQuantity!] : []
        ..feedingQuantity = feedingQuantity;

      // Save the meal first
      await service.saveMeal(mealToSubmit);

      // Iterate through the ratings and save or update them
      for (final entry in ratings.entries) {
        final cat = entry.key;
        final rating = entry.value;

        // Check if a rating for the same meal and cat already exists with the same value
        final existingRating =
            await service.getRatingForMealAndCat(mealToSubmit, cat);

        if (existingRating == null ||
            existingRating.mealRating != rating.mealRating) {
          // If no existing rating or the value has changed, save or update the rating
          rating.meal.value = mealToSubmit; // Link the rating to the meal
          await service.saveRating(rating);
        }
        // Otherwise, do nothing (rating already exists with the same value)
      }

      // Notify the callback if it is provided
      if (onSubmit != null) {
        onSubmit!(mealToSubmit);
      }
    }
  }
}
