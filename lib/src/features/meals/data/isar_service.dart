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

  Future<void> saveMeal(Meal newMeal) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.meals.putSync(newMeal));
  }

  Future<void> saveCat(Cat newCat) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.cats.putSync(newCat));
  }

  Future<void> saveCatAcceptance(CatAcceptance newCatAcceptance) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.catAcceptances.putSync(newCatAcceptance));
  }

  Future<List<Meal>> getAllMeals() async {
    final isar = await db;
    return isar.meals.where().findAll();
  }

  Future<List<Cat>> getAllCats() async {
    final isar = await db;
    return isar.cats.where().findAll();
  }

  Stream<List<Meal>> listenToMeals() async* {
    final isar = await db;
    yield* isar.meals.where().watch(fireImmediately: true);
  }

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
