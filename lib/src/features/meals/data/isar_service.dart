import 'package:cat_cuisine/src/features/meals/domain/cat_acceptance.dart';
import 'package:cat_cuisine/src/features/meals/domain/cat.dart';
import 'package:cat_cuisine/src/features/meals/domain/meal.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  // ***
  // Meal functions
  Future<void> saveMeal(Meal newMeal) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.meals.putSync(newMeal));
  }

  Future<List<Meal>> getAllMeals() async {
    final isar = await db;
    return isar.meals.where().findAll();
  }

  Stream<List<Meal>> listenToMeals() async* {
    final isar = await db;
    yield* isar.meals.where().watch(fireImmediately: true);
  }

  Future<void> updateMeal(Meal updatedMeal) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.meals.putSync(updatedMeal));
  }

  Future<void> deleteMeal(Meal meal) async {
    final isar = await db;
    await isar.writeTxn(() async {
      // Delete associated CatAcceptance objects
      for (final catAcceptance in meal.catAcceptances) {
        await isar.catAcceptances.delete(catAcceptance.id);
      }
      // Delete the meal
      await isar.meals.delete(meal.id);
    });
  }

  // ***
  // Cat functions
  Future<void> saveCat(Cat newCat) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.cats.putSync(newCat));
  }

  Future<List<Cat>> getAllCats() async {
    final isar = await db;
    return isar.cats.where().findAll();
  }

  Future<void> deleteCat(Cat cat) async {
    final isar = await db;
    await isar.writeTxn(() async {
      // Delete the cat
      await isar.cats.delete(cat.id);
    });
  }

  // ***
  // Acceptance Rating functions
  Future<void> saveCatAcceptance(CatAcceptance newCatAcceptance) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.catAcceptances.putSync(newCatAcceptance));
  }

  // ***
  // Database
  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [MealSchema, CatSchema, CatAcceptanceSchema],
        inspector: true,
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }
}
