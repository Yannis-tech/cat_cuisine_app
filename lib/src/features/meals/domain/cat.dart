import 'cat_acceptance.dart';
import 'package:isar/isar.dart';

part 'cat.g.dart';

@collection
class Cat {
  Id id = Isar.autoIncrement;
  String? name;

  @Backlink(to: 'cat')
  final catAcceptance = IsarLinks<CatAcceptance>();
}
