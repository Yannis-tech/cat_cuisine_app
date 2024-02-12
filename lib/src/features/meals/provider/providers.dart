import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/isar_service.dart';
import '../domain/meal.dart';
import '../model/manage_cat_view_model.dart';
import '../model/manage_meal_view_model.dart';

final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService();
});

final manageMealProvider =
    ChangeNotifierProvider.family<ManageMealViewModel, Meal?>((ref, meal) {
  final service = ref.read(isarServiceProvider);
  return ManageMealViewModel(service, meal: meal);
});

final manageCatProvider = ChangeNotifierProvider<ManageCatViewModel>((ref) {
  final service = ref.read(isarServiceProvider);
  return ManageCatViewModel(service);
});
