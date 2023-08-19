import 'package:isar/isar.dart';
import 'cat_acceptance.dart';

part 'meal.g.dart';

@collection
class Meal {
  Id id = Isar.autoIncrement;
  DateTime? dateOfEntry;
  String? timeOfDay;
  String? brand;
  String? mealSort;
  List<String>? quantities;
  String? feedingQuantity;
  final catAcceptances = IsarLinks<CatAcceptance>();
}
