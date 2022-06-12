import 'package:fruit_panda/achievement.dart';

enum Fruit {
  apple,
  avocado,
  banana,
  blueberries,
  cherry,
  dragonfruit,
  durian,
  grapes,
  kiwi,
  longan,
  mango,
  orange,
  pear,
  pineapple,
  strawberry,
  watermelon,
  unknown,
}

extension FruitProperName on Fruit {
  String get properName => const <Fruit, String>{
        Fruit.apple: "Apple",
        Fruit.avocado: "Avocado",
        Fruit.banana: "Banana",
        Fruit.blueberries: "Blueberries",
        Fruit.cherry: "Cherry",
        Fruit.dragonfruit: "Dragon fruit",
        Fruit.durian: "Durian",
        Fruit.grapes: "Grapes",
        Fruit.kiwi: "Kiwi",
        Fruit.longan: "Longan",
        Fruit.mango: "Mango",
        Fruit.orange: "Orange",
        Fruit.pear: "Pear",
        Fruit.pineapple: "Pineapple",
        Fruit.strawberry: "Strawberry",
        Fruit.watermelon: "Watermelon",
        Fruit.unknown: "Unknown",
      }[this]!;
}

const separator = "%%%";
const debug = true;

final achievements = [
  Achievement("Login for 0 days", Streak("login", 0).achieved),
  Achievement("Login for 1 days", Streak("login", 1).achieved),
  Achievement("Login for 2 days", Streak("login", 2).achieved),
  Achievement("Login for 3 days", Streak("login", 3).achieved),
  Achievement("Login for 30 days", Streak("login", 30).achieved),

  Achievement("Eat fruit for 0 days", Streak("eat", 0).achieved),
  Achievement("Eat fruit for 1 days", Streak("eat", 1).achieved),
  Achievement("Eat fruit for 2 days", Streak("eat", 2).achieved),
  Achievement("Eat fruit for 3 days", Streak("eat", 3).achieved),
  Achievement("Eat fruit for 30 days", Streak("eat", 30).achieved),
];