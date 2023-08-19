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
      backgroundColor: theme.colorScheme.background, // Using background color
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background, // Using primary color
        title: Text('Cat Cuisine', style: theme.textTheme.displayMedium),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                iconSize: 26,
                icon: Icon(Icons.pets),
                tooltip: 'Manage Cats',
                onPressed: () {},
              ),
              Positioned(
                right: 4,
                bottom: 8,
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.settings,
                    size: 12,
                    color: theme.iconTheme.color,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0, vertical: 28.0), // Increased padding
              child: StreamBuilder<List<Meal>>(
                stream: service.listenToMeals(),
                builder: (context, snapshot) => ListView(
                  children: snapshot.hasData
                      ? snapshot.data!.map((meal) {
                          return Padding(
                            padding: const EdgeInsetsDirectional.only(
                                top: 8, bottom: 8),
                            child: MealCard(
                              meal: meal,
                              onTap: () {
                                Meal selectedMeal = meal;
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.9,
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
                          );
                        }).toList()
                      : [],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: theme.colorScheme.onPrimary,
                backgroundColor: theme.colorScheme.primary,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12), // Set padding as needed
                minimumSize: const Size(88, 36), // Set minimum size as needed
              ),
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
              child: const Text("Add Meal"),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
