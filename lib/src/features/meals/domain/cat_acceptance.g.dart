// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_acceptance.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCatAcceptanceCollection on Isar {
  IsarCollection<CatAcceptance> get catAcceptances => this.collection();
}

const CatAcceptanceSchema = CollectionSchema(
  name: r'CatAcceptance',
  id: 5936871469674972486,
  properties: {
    r'acceptanceRating': PropertySchema(
      id: 0,
      name: r'acceptanceRating',
      type: IsarType.long,
    )
  },
  estimateSize: _catAcceptanceEstimateSize,
  serialize: _catAcceptanceSerialize,
  deserialize: _catAcceptanceDeserialize,
  deserializeProp: _catAcceptanceDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'cat': LinkSchema(
      id: 2724161067679066928,
      name: r'cat',
      target: r'Cat',
      single: true,
    ),
    r'meal': LinkSchema(
      id: -2623436091692686138,
      name: r'meal',
      target: r'Meal',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _catAcceptanceGetId,
  getLinks: _catAcceptanceGetLinks,
  attach: _catAcceptanceAttach,
  version: '3.1.0+1',
);

int _catAcceptanceEstimateSize(
  CatAcceptance object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _catAcceptanceSerialize(
  CatAcceptance object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.acceptanceRating);
}

CatAcceptance _catAcceptanceDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CatAcceptance();
  object.acceptanceRating = reader.readLong(offsets[0]);
  object.id = id;
  return object;
}

P _catAcceptanceDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _catAcceptanceGetId(CatAcceptance object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _catAcceptanceGetLinks(CatAcceptance object) {
  return [object.cat, object.meal];
}

void _catAcceptanceAttach(
    IsarCollection<dynamic> col, Id id, CatAcceptance object) {
  object.id = id;
  object.cat.attach(col, col.isar.collection<Cat>(), r'cat', id);
  object.meal.attach(col, col.isar.collection<Meal>(), r'meal', id);
}

extension CatAcceptanceQueryWhereSort
    on QueryBuilder<CatAcceptance, CatAcceptance, QWhere> {
  QueryBuilder<CatAcceptance, CatAcceptance, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CatAcceptanceQueryWhere
    on QueryBuilder<CatAcceptance, CatAcceptance, QWhereClause> {
  QueryBuilder<CatAcceptance, CatAcceptance, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterWhereClause> idBetween(
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

extension CatAcceptanceQueryFilter
    on QueryBuilder<CatAcceptance, CatAcceptance, QFilterCondition> {
  QueryBuilder<CatAcceptance, CatAcceptance, QAfterFilterCondition>
      acceptanceRatingEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'acceptanceRating',
        value: value,
      ));
    });
  }

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterFilterCondition>
      acceptanceRatingGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'acceptanceRating',
        value: value,
      ));
    });
  }

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterFilterCondition>
      acceptanceRatingLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'acceptanceRating',
        value: value,
      ));
    });
  }

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterFilterCondition>
      acceptanceRatingBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'acceptanceRating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterFilterCondition> idBetween(
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
}

extension CatAcceptanceQueryObject
    on QueryBuilder<CatAcceptance, CatAcceptance, QFilterCondition> {}

extension CatAcceptanceQueryLinks
    on QueryBuilder<CatAcceptance, CatAcceptance, QFilterCondition> {
  QueryBuilder<CatAcceptance, CatAcceptance, QAfterFilterCondition> cat(
      FilterQuery<Cat> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'cat');
    });
  }

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterFilterCondition>
      catIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cat', 0, true, 0, true);
    });
  }

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterFilterCondition> meal(
      FilterQuery<Meal> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'meal');
    });
  }

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterFilterCondition>
      mealIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'meal', 0, true, 0, true);
    });
  }
}

extension CatAcceptanceQuerySortBy
    on QueryBuilder<CatAcceptance, CatAcceptance, QSortBy> {
  QueryBuilder<CatAcceptance, CatAcceptance, QAfterSortBy>
      sortByAcceptanceRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acceptanceRating', Sort.asc);
    });
  }

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterSortBy>
      sortByAcceptanceRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acceptanceRating', Sort.desc);
    });
  }
}

extension CatAcceptanceQuerySortThenBy
    on QueryBuilder<CatAcceptance, CatAcceptance, QSortThenBy> {
  QueryBuilder<CatAcceptance, CatAcceptance, QAfterSortBy>
      thenByAcceptanceRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acceptanceRating', Sort.asc);
    });
  }

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterSortBy>
      thenByAcceptanceRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acceptanceRating', Sort.desc);
    });
  }

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CatAcceptance, CatAcceptance, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension CatAcceptanceQueryWhereDistinct
    on QueryBuilder<CatAcceptance, CatAcceptance, QDistinct> {
  QueryBuilder<CatAcceptance, CatAcceptance, QDistinct>
      distinctByAcceptanceRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'acceptanceRating');
    });
  }
}

extension CatAcceptanceQueryProperty
    on QueryBuilder<CatAcceptance, CatAcceptance, QQueryProperty> {
  QueryBuilder<CatAcceptance, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CatAcceptance, int, QQueryOperations>
      acceptanceRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'acceptanceRating');
    });
  }
}
