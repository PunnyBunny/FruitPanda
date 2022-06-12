import 'package:flutter/material.dart';
import 'package:fruit_panda/achievements_page.dart';
import 'package:fruit_panda/fruit_histories_page.dart';
import 'package:fruit_panda/fruit_profiles_page.dart';
import 'package:fruit_panda/panda_page.dart';
import 'package:fruit_panda/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fruit Panda'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SettingsPage())),
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            PandaPage(),
            FruitProfilesPage(),
            FruitHistoriesPage(),
            AchievementPage(),
          ],
        ),
        bottomNavigationBar: Material(
          color: Theme.of(context).colorScheme.primary,
          child: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.looks_one), child: Text('Fruit Panda')),
              Tab(icon: Icon(Icons.looks_two), child: Text('Fruit Profiles')),
              Tab(icon: Icon(Icons.looks_3), child: Text('Fruit Histories')),
              Tab(icon: Icon(Icons.looks_4), child: Text('Achievements')),
            ],
          ),
        ),
      ),
    );
  }
}
