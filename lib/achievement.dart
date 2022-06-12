import 'package:fruit_panda/streak_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Achievement {
  String name;
  bool Function(SharedPreferences) predicate; // returns true if achievement is unlocked

  Achievement(this.name, this.predicate);
}

class Streak {
  int threshold;
  String action;

  Streak(this.action, this.threshold);

  bool achieved(SharedPreferences prefs) {
    return StreakManager.getLongestStreak(prefs, action) >= threshold;
  }
}