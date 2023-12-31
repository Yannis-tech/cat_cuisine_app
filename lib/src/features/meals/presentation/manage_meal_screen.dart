import 'package:cat_cuisine/src/features/meals/domain/cat.dart';
import 'package:cat_cuisine/src/features/meals/domain/rating.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/brand_field.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/date_of_entry_field.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/feeding_quantity_field.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/meal_sort_field.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/quantities_field.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/rating_field.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/time_of_day_field.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../data/data_utils.dart';
import '../data/isar_service.dart';
import '../domain/meal.dart';

class ManageMealScreen extends StatefulWidget {
  final Meal? meal;
  final ValueChanged<Meal>? onSubmit;
  final IsarService service;

  // Existing meal constructor for updating
  ManageMealScreen.update({
    Key? key,
    required this.meal,
    required this.onSubmit,
    required this.service,
  }) : super(key: key);

  const ManageMealScreen(this.service, {Key? key})
      : meal = null,
        onSubmit = null,
        super(key: key);

  @override
  State<ManageMealScreen> createState() => _ManageMealScreenState();
}

class _ManageMealScreenState extends State<ManageMealScreen> {
  // Initialize form controllers
  DateTime _dateOfEntry = DateTime.now();
  void _onDateChanged(DateTime? newDate) {
    setState(() {
      _dateOfEntry = newDate ?? _dateOfEntry;
    });
  }

  String _timeOfDay = 'Morgens';
  void _onTimeOfDayChanged(String? newValue) {
    setState(() {
      _timeOfDay = newValue ?? _timeOfDay;
    });
  }

  String _brand = '';
  void _onBrandChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        _brand = newValue;
      });
    }
  }

  String? _mealSort;
  void _onMealSortChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        _mealSort = newValue;
      });
    }
  }

  List<String> _quantities = [];
  void _updateQuantities(List<Map<String, dynamic>> brandsData) {
    if (_brand.isNotEmpty && _mealSort != null) {
      final brandData =
          brandsData.firstWhere((brand) => brand['name'] == _brand);
      final mealData = (brandData['meals'] as List<dynamic>?)
          ?.firstWhere((meal) => meal['name'] == _mealSort, orElse: () => {});
      _quantities = List<String>.from(mealData?['quantities'] ?? []);
      if (_selectedQuantity == null ||
          !_quantities.contains(_selectedQuantity)) {
        _selectedQuantity = _quantities.isNotEmpty ? _quantities.first : null;
      }
    }
  }

  String? _selectedQuantity;

  String _feedingQuantity = 'halbe-halbe';
  void _onFeedingQuantityChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        _feedingQuantity = newValue;
      });
    }
  }

  Map<Cat, int> _ratings = {};

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize state variables based on existing meal or default values
    _dateOfEntry = widget.meal?.dateOfEntry ?? DateTime.now();
    _timeOfDay = widget.meal?.timeOfDay ?? 'Morgens';
    _brand = widget.meal?.brand ?? '';
    _mealSort = widget.meal?.mealSort;
    List<String>? quantities = widget.meal?.quantities;
    _selectedQuantity =
        quantities != null && quantities.isNotEmpty ? quantities[0] : null;
    _feedingQuantity = widget.meal?.feedingQuantity ?? 'halbe-halbe';
    // Fetch all cats
    widget.service.getAllCats().then((cats) async {
      // Fetch ratings for the current meal
      final List<Rating> ratings = widget.meal != null
          ? await widget.service.getRatingsForMeal(widget.meal!)
          : [];
      // Map the ratings to the corresponding cats
      setState(() {
        for (final cat in cats) {
          final ratingForCat = ratings
              .firstWhereOrNull((rating) => rating.cat.value?.id == cat.id);
          _ratings[cat] = ratingForCat?.mealRating ?? 3; // Default rating
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context); // Get the current theme

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: loadBrands(),
      builder: (context, snapshot) {
        // Init shapshot
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('An error occurred: ${snapshot.error}');
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          // Build
          final brandsData = snapshot.data!;
          final brandData = brandsData
              .firstWhere((brand) => brand['name'] == _brand, orElse: () => {});
          final mealsData = brandData['meals'] as List<dynamic>? ?? [];
          _updateQuantities(brandsData);

          return SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(24.0), // Increased padding
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0), // Increased padding
                    child: Form(
                      key: _formKey, // For validation
                      child: Column(
                        children: [
                          // Date of entry
                          DateOfEntryField(
                              dateOfEntry: _dateOfEntry,
                              onDateChanged: _onDateChanged),
                          SizedBox(height: 16),

                          // Time of day
                          TimeOfDayField(
                            timeOfDay: _timeOfDay,
                            onTimeOfDayChanged: _onTimeOfDayChanged,
                          ),
                          SizedBox(height: 16),

                          // For the Brand field
                          BrandField(
                            brand: _brand,
                            brands: snapshot.data ?? [],
                            onBrandChanged: _onBrandChanged,
                          ),
                          SizedBox(height: 16),

                          // For the Meal Sort Field
                          MealSortField(
                            mealSort: _mealSort ?? '',
                            meals: mealsData,
                            onMealSortChanged: (String? newValue) {
                              setState(() {
                                _mealSort = newValue;
                              });
                            },
                          ),
                          SizedBox(height: 16),

                          // Quantities Field
                          QuantitiesField(
                            selectedQuantity: _selectedQuantity ?? '',
                            quantities: _quantities,
                            onQuantityChanged: (String? newValue) {
                              setState(() {
                                _selectedQuantity =
                                    newValue ?? _selectedQuantity;
                              });
                            },
                          ),
                          SizedBox(height: 16),

                          // Feeding quantity
                          FeedingQuantityField(
                            feedingQuantity: _feedingQuantity,
                            onChanged: (String? newValue) {
                              setState(() {
                                _feedingQuantity = newValue ?? _feedingQuantity;
                              });
                            },
                          ),
                          SizedBox(height: 16),

                          RatingField(
                            cats: _ratings.keys.toList(),
                            ratings: _ratings,
                            onRatingChanged: (Cat cat, int rating) {
                              setState(() {
                                _ratings[cat] = rating;
                              });
                            },
                          ),
                          SizedBox(height: 16),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              minimumSize: const Size(88, 36),
                              foregroundColor: theme.colorScheme.onPrimary,
                              backgroundColor: theme.colorScheme.primary,
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final mealToSubmit = (widget.meal ?? Meal())
                                  ..dateOfEntry = _dateOfEntry
                                  ..timeOfDay = _timeOfDay
                                  ..brand = _brand
                                  ..mealSort = _mealSort
                                  ..quantities = _selectedQuantity != null
                                      ? [_selectedQuantity!]
                                      : []
                                  ..feedingQuantity = _feedingQuantity;
                                // Save the meal first
                                await widget.service.saveMeal(mealToSubmit);

                                // Iterate through the ratings and save them
                                for (final entry in _ratings.entries) {
                                  final cat = entry.key;
                                  final ratingValue = entry.value;

                                  // Create a Rating object
                                  final rating = Rating()
                                    ..mealRating = ratingValue
                                    ..cat.value = cat
                                    ..meal.value = mealToSubmit;

                                  // Save the rating
                                  await widget.service.saveRating(rating);
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Mahlzeit gespeichert!")));

                                Navigator.pop(context);
                              }
                            },
                            child: Text(widget.meal != null
                                ? "Mahlzeit aktualisieren"
                                : "Mahlzeit hinzufügen"), // Conditional text based on whether updating or adding
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
        } else {
          return Center(child: Text('Keine Daten gefunden.'));
        }
      },
    );
  }
}
