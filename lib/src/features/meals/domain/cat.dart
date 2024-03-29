import 'package:cat_cuisine/src/features/meals/domain/rating.dart';
import 'package:isar/isar.dart';

part 'cat.g.dart';

@Collection()
class Cat {
  Id id = Isar.autoIncrement;

  String? name;
  String? picturePath;

  @Backlink(to: 'cat')
  final ratings = IsarLinks<Rating>(); //Multiple ratings per cat (each meal)
}
