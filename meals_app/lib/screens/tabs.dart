import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/providers/favorite_meals_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/providers/meals_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _currentScreenIndex = 0;
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _onSelectItem(int index) {
    setState(
      () {
        _currentScreenIndex = index;
      },
    );
  }

  void _setScreen(String identifier) async {
    if (identifier == 'filters') {
      Navigator.of(context).pop();
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);

    final availableMeals = meals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isGlutenFree) {
        return false;
      }
      return true;
    }).toList();

    Widget activeScreen = CategoriesScreen(
      availableMeals: availableMeals,
    );

    final favoriteMeals = ref.watch(favoriteMealsProvider);

    if (_currentScreenIndex == 1) {
      activeScreen = MealsScreen(
        meals: favoriteMeals,
      );
    }

    return Scaffold(
      body: activeScreen,
      drawer: MainDrawer(onSelectTile: _setScreen),
      appBar: AppBar(
        title: Text(
          _currentScreenIndex == 0 ? 'Pick a Category' : 'Your Favorites',
        ),
      ),
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
