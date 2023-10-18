import 'package:flutter/material.dart';
import 'package:meals_app/data/categories_dummy.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleMealStatus});

  final void Function(MealModel meal) onToggleMealStatus;

  void _selectCategory(BuildContext context, CategoryModel category) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return MealsScreen(
            title: category.title,
            meals: filteredMeals,
            onToggleMealStatus: onToggleMealStatus,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pick a category',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 1.5,
          ),
          children: [
            // for (final category in availableCategories)
            //   CategoryGridItem(category: category)

            ...availableCategories.map(
              (category) => CategoryGridItem(
                onSelectCategory: () {
                  _selectCategory(context, category);
                },
                category: category,
              ),
            )
          ],
        ),
      ),
    );
  }
}
