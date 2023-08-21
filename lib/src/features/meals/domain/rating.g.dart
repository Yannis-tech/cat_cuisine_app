// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRatingCollection on Isar {
  IsarCollection<Rating> get ratings => this.collection();
}

const RatingSchema = CollectionSchema(
  name: r'Rating',
  id: 8466231695326758890,
  properties: {
    r'mealRating': PropertySchema(
      id: 0,
      name: r'mealRating',
      type: IsarType.long,
    )
  },
  estimateSize: _ratingEstimateSize,
  serialize: _ratingSerialize,
  deserialize: _ratingDeserialize,
  deserializeProp: _ratingDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'cat': LinkSchema(
      id: 201669019693341040,
      name: r'cat',
      target: r'Cat',
      single: true,
    ),
    r'meal': LinkSchema(
      id: 5886857035885779942,
      name: r'meal',
      target: r'Meal',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _ratingGetId,
  getLinks: _ratingGetLinks,
  attach: _ratingAttach,
  version: '3.1.0+1',
);

int _ratingEstimateSize(
  Rating object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _ratingSerialize(
  Rating object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.mealRating);
}

Rating _ratingDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Rating();
  object.id = id;
  object.mealRating = reader.readLongOrNull(offsets[0]);
  return object;
}

P _ratingDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _ratingGetId(Rating object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _ratingGetLinks(Rating object) {
  return [object.cat, object.meal];
}

void _ratingAttach(IsarCollection<dynamic> col, Id id, Rating object) {
  object.id = id;
  object.cat.attach(col, col.isar.collection<Cat>(), r'cat', id);
  object.meal.attach(col, col.isar.collection<Meal>(), r'meal', id);
}

extension RatingQueryWhereSort on QueryBuilder<Rating, Rating, QWhere> {
  QueryBuilder<Rating, Rating, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RatingQueryWhere on QueryBuilder<Rating, Rating, QWhereClause> {
  QueryBuilder<Rating, Rating, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Rating, Rating, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Rating, Rating, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Rating, Rating, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Rating, Rating, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RatingQueryFilter on QueryBuilder<Rating, Rating, QFilterCondition> {
  QueryBuilder<Rating, Rating, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Rating, Rating, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Rating, Rating, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Rating, Rating, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Rating, Rating, QAfterFilterCondition> mealRatingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mealRating',
      ));
    });
  }

  QueryBuilder<Rating, Rating, QAfterFilterCondition> mealRatingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mealRating',
      ));
    });
  }

  QueryBuilder<Rating, Rating, QAfterFilterCondition> mealRatingEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mealRating',
        value: value,
      ));
    });
  }

  QueryBuilder<Rating, Rating, QAfterFilterCondition> mealRatingGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mealRating',
        value: value,
      ));
    });
  }

  QueryBuilder<Rating, Rating, QAfterFilterCondition> mealRatingLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mealRating',
        value: value,
      ));
    });
  }

  QueryBuilder<Rating, Rating, QAfterFilterCondition> mealRatingBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mealRating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RatingQueryObject on QueryBuilder<Rating, Rating, QFilterCondition> {}

extension RatingQueryLinks on QueryBuilder<Rating, Rating, QFilterCondition> {
  QueryBuilder<Rating, Rating, QAfterFilterCondition> cat(FilterQuery<Cat> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'cat');
    });
  }

  QueryBuilder<Rating, Rating, QAfterFilterCondition> catIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cat', 0, true, 0, true);
    });
  }

  QueryBuilder<Rating, Rating, QAfterFilterCondition> meal(
      FilterQuery<Meal> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'meal');
    });
  }

  QueryBuilder<Rating, Rating, QAfterFilterCondition> mealIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'meal', 0, true, 0, true);
    });
  }
}

extension RatingQuerySortBy on QueryBuilder<Rating, Rating, QSortBy> {
  QueryBuilder<Rating, Rating, QAfterSortBy> sortByMealRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealRating', Sort.asc);
    });
  }

  QueryBuilder<Rating, Rating, QAfterSortBy> sortByMealRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealRating', Sort.desc);
    });
  }
}

extension RatingQuerySortThenBy on QueryBuilder<Rating, Rating, QSortThenBy> {
  QueryBuilder<Rating, Rating, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Rating, Rating, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Rating, Rating, QAfterSortBy> thenByMealRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealRating', Sort.asc);
    });
  }

  QueryBuilder<Rating, Rating, QAfterSortBy> thenByMealRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealRating', Sort.desc);
    });
  }
}

extension RatingQueryWhereDistinct on QueryBuilder<Rating, Rating, QDistinct> {
  QueryBuilder<Rating, Rating, QDistinct> distinctByMealRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mealRating');
    });
  }
}

extension RatingQueryProperty on QueryBuilder<Rating, Rating, QQueryProperty> {
  QueryBuilder<Rating, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Rating, int?, QQueryOperations> mealRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mealRating');
    });
  }
}
