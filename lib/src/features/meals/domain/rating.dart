import 'package:cat_cuisine/src/features/meals/domain/cat.dart';
import 'package:cat_cuisine/src/features/meals/domain/meal.dart';
import 'package:isar/isar.dart';

part 'rating.g.dart';

enum AcceptanceRating {
  good,
  ok,
  bad,
}

@collection
class Rating {
  Id id = Isar.autoIncrement;
  int? mealRating;

  final cat = IsarLink<Cat>(); // One cat per rating
  final meal = IsarLink<Meal>(); // One meal per rating
}
