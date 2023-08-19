import 'package:cat_cuisine/src/features/meals/data/isar_service.dart';
import 'package:cat_cuisine/src/features/meals/domain/meal.dart';
import 'package:cat_cuisine/src/features/meals/presentation/manage_meal_screen.dart';
import 'package:cat_cuisine/src/features/meals/presentation/meal_card.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final service = IsarService();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface, // Using background color
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background, // Using primary color
        title: Text('Cat Cuisine', style: theme.textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 12.0, vertical: 28.0), // Increased padding
        child: StreamBuilder<List<Meal>>(
          stream: service.listenToMeals(),
          //
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
                          color: theme.colorScheme
                              .error, // Background color when swiping
                          child: Icon(Icons.delete,
                              color: theme.colorScheme.onError),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
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
                            onTap: () {
                              Meal selectedMeal = meal;
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.9,
                                  child: ManageMealScreen.update(
                                    meal: selectedMeal,
                                    onSubmit: (updatedMeal) {
                                      service.updateMeal(updatedMeal);
                                    },
                                    service: service,
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.colorScheme.background,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Katzenhotel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz), // Placeholder icon
            label: 'Mehr', // Placeholder label
          ),
          // You can add more items here
        ],
        onTap: (index) {
          // Handle navigation based on the selected index
        },
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
              child: ManageMealScreen(service),
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
