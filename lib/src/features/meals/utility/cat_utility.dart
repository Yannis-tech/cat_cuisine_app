import 'package:flutter/material.dart';

class CatUtility {
  static void showAddCatDialog(BuildContext context, Function saveCat) {
    final catNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Katze hinzufügen'),
        content: TextField(
          controller: catNameController,
          decoration: InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(
            child: Text('Abbrechen'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text('Bestätigen'),
            onPressed: () {
              saveCat(catNameController.text);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  // You can add more utility functions here
}
