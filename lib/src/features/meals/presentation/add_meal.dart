import 'package:cat_cuisine/src/features/meals/presentation/widgets/brand_field.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/date_of_entry_field.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/feeding_quantity_field.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/meal_sort_field.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/quantities_field.dart';
import 'package:cat_cuisine/src/features/meals/presentation/widgets/time_of_day_field.dart';
import 'package:flutter/material.dart';
import '../data/data_utils.dart';
import '../data/isar_service.dart';
import '../domain/meal.dart';

class AddMeal extends StatefulWidget {
  final Meal? meal;
  final ValueChanged<Meal>? onSubmit;
  final IsarService service;

  // Existing meal constructor for updating
  AddMeal.update({
    Key? key,
    required this.meal,
    required this.onSubmit,
    required this.service,
  }) : super(key: key);

  const AddMeal(this.service, {Key? key})
      : meal = null,
        onSubmit = null,
        super(key: key);

  @override
  State<AddMeal> createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
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
      final mealData =
          brandData['meals'].firstWhere((meal) => meal['name'] == _mealSort);
      _quantities = List<String>.from(mealData?['quantities'] ?? []);
      _selectedQuantity = _quantities.first;
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
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: loadBrands(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('An error occurred: ${snapshot.error}');
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
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

                          SizedBox(height: 16),
                          ElevatedButton(
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
                                  if (widget.onSubmit != null) {
                                    widget.onSubmit!(mealToSubmit);
                                  } else {
                                    widget.service.saveMeal(mealToSubmit);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("New meal saved in DB")));
                                  }

                                  Navigator.pop(context);
                                }
                              },
                              child: const Text("Add new meal"))
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
