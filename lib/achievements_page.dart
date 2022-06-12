import 'package:flutter/material.dart';
import 'package:fruit_panda/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AchievementPage extends StatelessWidget {
  const AchievementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        final prefs = snapshot.data as SharedPreferences;
        return ListView.builder(
          itemBuilder: (context, index) {
            final completed = achievements[index].predicate(prefs);
            return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: ListTile(title: Text(achievements[index].name)),
                color: completed ? Colors.amber : Colors.white,
              ),
            );
          },
          itemCount: achievements.length,
        );
      },
    );
  }
}
