import 'package:flutter/material.dart';

import '../data/isar_service.dart';
import '../domain/cat.dart';
import '../domain/meal.dart';
import 'add_meal.dart';

class UpdateMeal extends StatelessWidget {
  final Meal meal;
  final VoidCallback? onMealUpdated;
  final List<Cat> cats;
  final IsarService service;

  static void navigate(context, Meal meal, List<Cat> cats,
      VoidCallback? onMealUpdated, IsarService service) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UpdateMeal(
          meal: meal,
          onMealUpdated: onMealUpdated,
          cats: cats,
          service: service);
    }));
  }

  const UpdateMeal(
      {Key? key,
      required this.meal,
      required this.onMealUpdated,
      required this.cats,
      required this.service})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mahlzeit aktualisieren'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: AddMeal.update(
              meal: meal, // Pass the existing meal to the form
              onSubmit: (updatedMeal) async {
                await service.saveMeal(
                    updatedMeal); // Use the Isar service to update the meal

                if (onMealUpdated != null) {
                  onMealUpdated!();
                }
                Navigator.pop(context);
              },
              service: service,
            ),
          ),
        ),
      ),
    );
  }
}
