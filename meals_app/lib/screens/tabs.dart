import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentScreenIndex = 0;

  void _onSelectItem(int index) {
    setState(
      () {
        _currentScreenIndex = index;
      },
    );
  }

  // creating an array in which favorite meals will be pushed into  when marked as favorites
  final List<MealModel> _favoriteMeals = [];

  void _toogleFavoriteMealStatus(MealModel meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      _favoriteMeals.remove(meal);
    } else {
      _favoriteMeals.add(meal);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(
      onToggleMealStatus: _toogleFavoriteMealStatus,
    );

    if (_currentScreenIndex == 1) {
      activeScreen = MealsScreen(
        title: 'Your Favorites',
        meals: _favoriteMeals,
        onToggleMealStatus: _toogleFavoriteMealStatus,
      );
    }

    return Scaffold(
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreenIndex,
        onTap: (index) {
          _onSelectItem(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
