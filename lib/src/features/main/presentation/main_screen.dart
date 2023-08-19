import 'package:cat_cuisine/src/features/meals/data/isar_service.dart';
import 'package:flutter/material.dart';

import '../../meals/domain/cat.dart';
import '../../meals/domain/meal.dart';
import '../../meals/presentation/add_meal.dart';
import '../../meals/presentation/update_meal.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final service = IsarService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Cat Cuisine'),
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
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<List<Meal>>(
                stream: service.listenToMeals(),
                builder: (context, snapshot) => GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  scrollDirection: Axis.horizontal,
                  children: snapshot.hasData
                      ? snapshot.data!.map((meal) {
                          return ElevatedButton(
                            onPressed: () {
                               List<Cat> cats = service.getAllCats();
    Meal selectedMeal = /* obtain or define the selected meal here */;
                              // Here we navigate to the UpdateMeal screen.
                              UpdateMeal.navigate(context, selectedMeal, cats, onMealUpdated, service);
                            },
                            child: Text(meal.dateOfEntry.toString()),
                          );
                        }).toList()
                      : [],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled:
                    true, // Allows full control over the modal's height
                builder: (context) => SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.9, // 90% of screen height
                  child: AddMeal(service),
                ),
              );
            },
            child: const Text("Add Meal"),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
