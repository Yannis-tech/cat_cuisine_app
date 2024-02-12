import 'package:flutter/material.dart';

import '../data/isar_service.dart';
import '../domain/cat.dart';

class ManageCatViewModel extends ChangeNotifier {
  final IsarService service;
  List<Cat> cats = [];
  bool isLoading = true;

  ManageCatViewModel(this.service) {
    fetchCats();
  }

  Future<void> fetchCats() async {
    isLoading = true;
    notifyListeners();
    cats = await service.getAllCats();
    isLoading = false;
    notifyListeners();
  }

  Future<void> saveCat(String catName) async {
    if (catName.isNotEmpty) {
      final newCat = Cat()..name = catName;
      await service.saveCat(newCat);
      await fetchCats();
    }
  }

  Future<void> updateCat(Cat cat) async {
    // Update the cat in the database
    await service.updateCat(cat);
    // Fetch the updated list of cats
    await fetchCats();
  }

  Future<void> deleteCat(Cat cat) async {
    await service.deleteCat(cat);
    await fetchCats();
  }
}
