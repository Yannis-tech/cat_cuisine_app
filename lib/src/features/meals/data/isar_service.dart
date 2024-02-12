import 'package:cat_cuisine/src/features/meals/domain/cat.dart';
import 'package:cat_cuisine/src/features/meals/domain/meal.dart';
import 'package:cat_cuisine/src/features/meals/domain/rating.dart';
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

  Future<List<Meal>> getLast20Meals() async {
    final isar = await db;
    List<Meal> meals = isar.meals.where().findAllSync();
    meals.sort((a, b) {
      int dateComparison = (b.dateOfEntry ?? DateTime.now())
          .compareTo(a.dateOfEntry ?? DateTime.now());
      if (dateComparison != 0) {
        return dateComparison;
      } else {
        return b.getTimeOfDayIndex().compareTo(a.getTimeOfDayIndex());
      }
    });
    return meals.take(20).toList();
  }

  Stream<List<Meal>> listenToMeals() async* {
    final isar = await db;
    await for (var meals in isar.meals.where().watch(fireImmediately: true)) {
      meals.sort((a, b) {
        int dateComparison = (b.dateOfEntry ?? DateTime.now())
            .compareTo(a.dateOfEntry ?? DateTime.now());
        if (dateComparison != 0) {
          return dateComparison;
        } else {
          return b.getTimeOfDayIndex().compareTo(a.getTimeOfDayIndex());
        }
      });
      yield meals.take(20).toList();
    }
  }

  Future<List<Meal>> getAllMeals() async {
    final isar = await db;
    return isar.meals.where().findAllSync();
  }

  Future<void> updateMeal(Meal updatedMeal) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.meals.putSync(updatedMeal));
  }

  Future<void> deleteMeal(Meal meal) async {
    final isar = await db;
    await isar.writeTxn(() async {
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

  Future<void> updateCat(Cat updatedCat) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.cats.putSync(updatedCat));
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
  Future<void> saveRating(Rating newRating) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.ratings.putSync(newRating));
  }

  Future<void> updateRating(Rating updatedRating) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.ratings.putSync(updatedRating));
  }

  Future<void> deleteRating(Rating rating) async {
    final isar = await db;
    await isar.writeTxn(() async {
      // Delete the cat
      await isar.ratings.delete(rating.id);
    });
  }

  // Get the acceptance ratings for a specific meal
  Future<List<Rating>> getRatingsForMeal(Meal meal) async {
    final isar = await db;
    return await isar.ratings
        .where()
        .filter()
        .meal((q) => q.idEqualTo(meal.id))
        .findAll();
  }

  Future<Meal?> getMealForRating(Rating rating) async {
    final isar = await db;
    return await isar.meals
        .where()
        .filter()
        .ratings((q) => q.idEqualTo(rating.id))
        .findFirst();
  }

  Future<List<Cat>> getCatForRating(Rating rating) async {
    final isar = await db;
    return await isar.cats
        .where()
        .filter()
        .ratings((q) => q.idEqualTo(rating.id))
        .findAll();
  }

  Future<List<Rating>> getRatingsForCat(Cat cat) async {
    final isar = await db;
    return await isar.ratings
        .where()
        .filter()
        .cat((q) => q.idEqualTo(cat.id))
        .findAll();
  }

  Future<Rating?> getRatingForMealAndCat(Meal meal, Cat cat) async {
    final isar = await db;
    final ratings = await isar.ratings
        .where()
        .filter()
        .meal((q) => q.idEqualTo(meal.id))
        .cat((q) => q.idEqualTo(cat.id))
        .findAll();

    if (ratings.isNotEmpty) {
      // If ratings exist, return the first one (assuming there should be only one per meal and cat)
      return ratings.first;
    } else {
      // No rating found for the specified meal and cat
      return null;
    }
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
        [MealSchema, CatSchema, RatingSchema],
        inspector: true,
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }
}
