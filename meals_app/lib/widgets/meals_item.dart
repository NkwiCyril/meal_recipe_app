import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meals_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class Meals extends StatelessWidget {
  const Meals({super.key, required this.meal, required this.onSelectMeal});

  final MealModel meal;
  final void Function(MealModel meal) onSelectMeal; //

  String get complexityText {
    // change the first character of the word to uppercase
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(
          1,
        );
  }

  String get affordabilityText {
    // change the first character of the word to uppercase
    return meal.affordability.name[0].toUpperCase() + 
    // concatencation of uppercase character and the rest of the characters in the word
        meal.affordability.name.substring(
          1, // from [1] to the last character
        );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelectMeal(meal);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 7,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage), 
              // transparent image displayed before the NetworkImage is done loading
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 22,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          trait: '${meal.duration.toString()} min',
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                          icon: Icons.work,
                          trait: complexityText,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          trait: affordabilityText,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
