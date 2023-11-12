import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/categories_dummy.dart';

final mealsProvider = Provider(
  (ref) {
    return dummyMeals;
  },
);
