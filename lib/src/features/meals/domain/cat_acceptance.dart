import 'package:isar/isar.dart';
import 'cat.dart';

part 'cat_acceptance.g.dart';

enum AcceptanceRating {
  good,
  ok,
  bad,
}

@collection
class CatAcceptance {
  Id id = Isar.autoIncrement;
  final cat = IsarLink<Cat>();
  late int acceptanceRating;
}
