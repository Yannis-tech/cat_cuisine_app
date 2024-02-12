import 'package:cat_cuisine/src/features/meals/presentation/main_meal_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_cuisine/src/features/meals/domain/meal.dart';
import 'package:cat_cuisine/src/features/meals/presentation/manage_cat_screen.dart';
import 'package:cat_cuisine/src/features/meals/presentation/manage_meal_screen.dart';
import 'package:cat_cuisine/src/features/meals/presentation/meal_card.dart';
import 'package:flutter/material.dart';

import '../../meals/provider/providers.dart';
import '../provider/main_providers.dart';

class MainScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);

    final selectedIndex = ref.watch(selectedIndexProvider);
    final pages = [
      MainMealScreen(),
      ManageCatScreen(),
      // Add more pages as per your navigation items
    ];

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        title: Text('Cat Cuisine', style: theme.textTheme.headlineSmall),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: 12.0,
            right: 12.0,
            top: 28.0,
            bottom: 10.0 // Adjust this padding as needed
            ),
        child: pages[selectedIndex], // Display the selected page with padding
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: theme.colorScheme.onSurface,
        unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.5),
        currentIndex: selectedIndex,
        onTap: (index) =>
            ref.read(selectedIndexProvider.notifier).state = index,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank), label: 'Mahlzeiten'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Katzenhotel'),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_list), label: 'Filter'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'Mehr'),
          // Add more items as needed
        ],
      ),
    );
  }
}
