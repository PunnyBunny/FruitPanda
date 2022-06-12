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
