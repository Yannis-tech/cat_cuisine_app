import 'package:cat_cuisine/src/features/meals/data/isar_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_cuisine/src/features/meals/domain/meal.dart';
import 'package:cat_cuisine/src/features/meals/presentation/manage_meal_screen.dart';
import 'package:cat_cuisine/src/features/meals/presentation/meal_card.dart';
import 'package:flutter/material.dart';

class MainMealScreen extends ConsumerWidget {
  final service = IsarService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Meals"),
      ),
      body: StreamBuilder<List<Meal>>(
        stream: service.listenToMeals(),
        builder: (context, snapshot) => ListView(
          children: snapshot.hasData
              ? snapshot.data!.map((meal) {
                  return Padding(
                    padding:
                        const EdgeInsetsDirectional.only(top: 8, bottom: 8),
                    child: Dismissible(
                      key: ValueKey(
                          meal.id), // Unique key for the Dismissible widget
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: theme.colorScheme.error,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(
                            right: 20), // Background color when swiping
                        child: Icon(Icons.delete,
                            color: theme.colorScheme.onError),
                      ),
                      onDismissed: (direction) {
                        service.deleteMeal(
                            meal); // Assuming you have a deleteMeal method
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Mahlzeit gelöscht!")),
                        );
                      },
                      child: GestureDetector(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text('Mahlzeit löschen?'),
                              content: Text(
                                  'Möchten Sie diese Mahlzeit wirklich löschen?'),
                              actions: [
                                TextButton(
                                  child: Text('Nein',
                                      style: theme.textTheme.labelMedium),
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Ja'),
                                  onPressed: () {
                                    service.deleteMeal(
                                        meal); // Assuming you have a deleteMeal method
                                    Navigator.of(ctx).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: MealCard(
                          meal: meal,
                          ratings: meal.ratings.toList(),
                          onTap: () {
                            Meal selectedMeal = meal;
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.9,
                                child: ManageMealScreen(
                                  service: service,
                                  meal: selectedMeal,
                                  onSubmit: (updatedMeal) {
                                    service.updateMeal(updatedMeal);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }).toList()
              : [],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled:
                true, // Allows full control over the modal's height
            builder: (context) => SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.9, // 90% of screen height
              child: ManageMealScreen(
                service: service,
              ),
            ),
          );
        },
        icon: Icon(Icons.add),
        label: Text('Erstellen',
            style: theme.textTheme.labelMedium
                ?.copyWith(color: theme.colorScheme.onSecondaryContainer)),
        backgroundColor: theme.colorScheme.secondaryContainer,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
