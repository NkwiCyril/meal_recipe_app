import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSelectTile,
  });

  final void Function(String identifier) onSelectTile ;

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.80),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fastfood,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "What's cooking?",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            onTap: () {
              onSelectTile('Meals');
            },
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            leading: Icon(
              Icons.fastfood,
              size: 24,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          ListTile(
            onTap: () {
              onSelectTile('filters');
            },
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            leading: Icon(
              Icons.settings,
              size: 24,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          )
        ],
      ),
    );
  }
}
