import 'package:flutter/material.dart';
// import 'package:meals_app/data/categories_dummy.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meals_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.meals,
  });

  final List<MealModel> meals;

  void selectMeal(BuildContext context, MealModel meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return MealDetailsScreen(
            meal: meal,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget emptyContent = Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Oops!..Nothing here.',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Try selecting a different category.',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            )
          ],
        ),
      ),
    );

    Widget filledContent = Scaffold(
      appBar: AppBar(
        title: const Text('Meals'),
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) {
          return Meals(
            meal: meals[index],
            onSelectMeal: (meal) {
              selectMeal(context, meal);
            },
          );
        },
      ),
    );

    Widget content = meals.isEmpty ? emptyContent : filledContent;

    return content;
  }
}
