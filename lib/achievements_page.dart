import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/button2_long" +
                        (completed ? ".png" : "_dark.png"),
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(achievements[index].name),
                      leading: Icon(
                        completed
                            ? FontAwesomeIcons.check
                            : FontAwesomeIcons.xmark,
                      ),
                    ),
                  ),
                ],
                alignment: Alignment.center,
              ),
            );
          },
          itemCount: achievements.length,
        );
      },
    );
  }
}
