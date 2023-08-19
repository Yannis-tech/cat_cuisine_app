import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<Map<String, dynamic>>> loadBrands() async {
  String jsonString =
      await rootBundle.loadString('assets/data/brand_data.json');
  Map<String, dynamic> jsonData = json.decode(jsonString);
  return List<Map<String, dynamic>>.from(jsonData['brands']);
}
