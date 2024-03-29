import 'package:cat_cuisine/src/features/meals/domain/rating.dart';
import 'package:isar/isar.dart';

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

  @Backlink(to: 'meal')
  final ratings = IsarLinks<Rating>(); // Multiple ratings per meal (each cat)

  int getTimeOfDayIndex() {
    switch (timeOfDay) {
      case 'Morgens':
        return 3;
      case 'Mittags':
        return 2;
      case 'Abends':
        return 1;
      default:
        return 0;
    }
  }
}
