import 'package:fruit_panda/achievement.dart';

enum Fruit {
  apple,
  banana,
  blueberry,
  cherry,
  grapes,
  kiwi,
  mango,
  orange,
  pineapple,
  unknown,
}

extension FruitProperName on Fruit {
  String get properName => const <Fruit, String>{
        Fruit.apple: "Apple",
        Fruit.banana: "Banana",
        Fruit.blueberry: "Blueberries",
        Fruit.cherry: "Cherry",
        Fruit.grapes: "Grapes",
        Fruit.kiwi: "Kiwi",
        Fruit.mango: "Mango",
        Fruit.orange: "Orange",
        Fruit.pineapple: "Pineapple",
        Fruit.unknown: "Unknown",
      }[this]!;
}

const separator = "%%%";
const debug = false;

final achievements = [
  Achievement("Make your first login", Streak("login", 1).achieved),
  Achievement("Login for 3 days consecutively", Streak("login", 3).achieved),
  Achievement("Login for 10 days consecutively", Streak("login", 10).achieved),
  Achievement("Login for 30 days consecutively", Streak("login", 30).achieved),

  Achievement("Eat your first fruit", Streak("eat", 1).achieved),
  Achievement("Eat fruit for 3 days consecutively", Streak("eat", 3).achieved),
  Achievement("Eat fruit for 10 days consecutively", Streak("eat", 10).achieved),
  Achievement("Eat fruit for 30 days consecutively", Streak("eat", 30).achieved),
];