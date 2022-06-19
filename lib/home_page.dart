import 'package:flutter/material.dart';
import 'package:fruit_panda/achievements_page.dart';
import 'package:fruit_panda/fruit_histories_page.dart';
import 'package:fruit_panda/fruit_profiles_page.dart';
import 'package:fruit_panda/panda_page.dart';
import 'package:fruit_panda/settings_page.dart';
import 'package:fruit_panda/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WithBackground(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Fruit Panda',
              style: Theme.of(context).textTheme.headline6,
            ),
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
          bottomNavigationBar: Container(
            height: 100,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, 5),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
              color: Theme.of(context).colorScheme.surface,
            ),
            child: TabBar(
              tabs: [
                _bottomTab("Panda", "panda2"),
                _bottomTab("Fruits", "fruits2"),
                _bottomTab("History", "analysis2"),
                _bottomTab("Trophies", "trophy"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomTab(String description, String imageFilename) {
    return Tab(
      height: 100,
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset("assets/images/button.png", height: 80),
              Image.asset("assets/images/icons/$imageFilename.png", height: 30),
            ],
            alignment: Alignment.center,
          ),
          Text(description),
        ],
      ),
    );
  }
}
