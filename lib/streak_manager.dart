import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class StreakManager {
  // perform an action for streak counting
  static Future<void> perform(String action) async {
    final prefs = await SharedPreferences.getInstance();
    var longestStreak = prefs.getInt("${action}LongestStreak") ?? 0;
    var currentStreak = prefs.getInt("${action}CurrentStreak") ?? 0;
    final actionLastDate =
        DateTime.parse(getLastDate(prefs, action)); // first day
    final now = DateTime.now();

    if (actionLastDate.day == now.day) return; // logged in today, do nothing
    if (actionLastDate.day == now.day - 1) {
      // logged in yesterday
      ++currentStreak;
    } else {
      // yesterday didn't log in
      currentStreak = 1;
    }
    longestStreak = max(longestStreak, currentStreak);

    prefs.setInt("${action}LongestStreak", longestStreak);
    prefs.setInt("${action}CurrentStreak", currentStreak);
    prefs.setString("${action}LastDate", now.toIso8601String());
  }

  static int getLongestStreak(SharedPreferences prefs, String action) {
    return prefs.getInt("${action}LongestStreak") ?? 0;
  }

  static String getLastDate(SharedPreferences prefs, String action) {
    return prefs.getString("${action}LastDate") ??
        DateTime.fromMicrosecondsSinceEpoch(0).toIso8601String();
  }
}
