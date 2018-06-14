import 'data.dart';
import 'hero_selection.dart';

Data data = Data();

class Hero {
  String name;
  double percentage;

  Hero(this.name, this.percentage);

  @override
  bool operator ==(other) {
    return other is Hero && name == other.name;
  }

  int _hashCode;
  @override
  int get hashCode {
    if (_hashCode == null) {
      _hashCode = name.hashCode;
    }
    return _hashCode;
  }

  @override
  String toString() {
    return '$name $percentage';
  }
}

List<Hero> calculateAdvantage(List<HeroSelectedItem> selected) {
  List<String> lineup = selected.map((e) => e.name).toList();

  List<Hero> advantages = [];
  data.matchups.forEach((enemy, val) {
    lineup.forEach((hero) {
      if (lineup.indexOf(enemy) > -1) return;

      int _index = advantages.indexOf(Hero(enemy, 0.0));
      if (_index == -1) {
        advantages.add(Hero(enemy, 0.0));
        _index = advantages.length - 1;
      }

      advantages[_index].percentage +=
          double.parse(data.matchups[hero]['matchups'][enemy][0]);
    });
  });

  advantages.sort((a, b) {
    return b.percentage.compareTo(a.percentage);
  });

  return advantages;
}
