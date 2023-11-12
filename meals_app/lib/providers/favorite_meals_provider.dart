import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteMealsProvider extends StateNotifier<List<MealModel>> {
  FavoriteMealsProvider()
      : super([]); // the initial value of the data in the notifier

  bool toggleMealsFavoriteStatus(MealModel meal) {
    // method that will trigger a change in the value
    final mealFavorite = state.contains(meal);
    if (mealFavorite) {
      state.where((m) => m.id != meal.id).toList();
      // in this case we don't use the add() function because we will be editing the value in memory
      // we rather create a new list by checking whether the following properties are satisfied

      return false;

    } else {
      state = [...state, meal];
      // pull out and add all the existing meals to the new list and add the meal which has been selected
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsProvider, List<MealModel>>(
  (ref) => FavoriteMealsProvider(),
);
