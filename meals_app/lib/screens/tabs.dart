import 'package:flutter/material.dart';
import 'package:meals_app/data/categories_dummy.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentScreenIndex = 0;
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _onSelectItem(int index) {
    setState(
      () {
        _currentScreenIndex = index;
      },
    );
  }

  // creating an array in which favorite meals will be pushed into  when marked as favorites
  final List<MealModel> _favoriteMeals = [];

  void _displayMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toogleFavoriteMealStatus(MealModel meal) {
    // checks if the favorite meals lists contains that meal already then removes it if true
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(
        () {
          _favoriteMeals.remove(meal);
        },
      );
      _displayMessage('Meal removed from favorites.');
    } else {
      setState(
        () {
          _favoriteMeals.add(meal);
        },
      );
      _displayMessage('Meal added to favorites.');
// add that meal if it has not yet been added
    }
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
    final availableMeals = dummyMeals.where((meal) {
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
      onToggleMealStatus: _toogleFavoriteMealStatus,
      availableMeals: availableMeals,
    );

    if (_currentScreenIndex == 1) {
      activeScreen = MealsScreen(
        meals: _favoriteMeals,
        onToggleMealStatus: _toogleFavoriteMealStatus,
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
