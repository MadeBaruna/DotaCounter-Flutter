import 'dart:async';
import 'package:meta/meta.dart';

import 'package:rxdart/subjects.dart';

import '../data.dart';
import '../hero_item.dart';
import '../hero_selection.dart';
import '../find_counter.dart';
import '../hero_recommendation_item.dart';

class HeroAddition {
  String codename;
  String hero;
  bool add;

  HeroAddition({
    @required this.codename,
    @required this.hero,
    @required this.add,
  });
}

class FilterValue {
  int index;
  bool value;

  FilterValue(this.index, this.value);
}

class StateBloc {
  final List<HeroSelectedItem> _selectedHeroes = [];
  final List<HeroItem> _searchResult = [];
  final List<bool> _filter = [true, true, true, true, true];
  final List<String> _filterString = [
    'Carry',
    'Support',
    'Disabler',
    'Initiator',
    'Durable'
  ];
  List<Hero> _advantages;
  String keyword = '';

  // selected heroes
  final StreamController<HeroAddition> _heroStateController =
      StreamController<HeroAddition>();
  Sink<HeroAddition> get heroState => _heroStateController.sink;

  final BehaviorSubject<List<HeroSelectedItem>> _heroes =
      BehaviorSubject<List<HeroSelectedItem>>(seedValue: []);
  Stream<List<HeroSelectedItem>> get selectedHeroes => _heroes.stream;

  // search query
  final StreamController<String> _queryStateController =
      StreamController<String>();
  Sink<String> get queryState => _queryStateController.sink;

  final BehaviorSubject<String> _query = BehaviorSubject<String>(seedValue: '');
  Stream<String> get query => _query.stream;

  // search result
  final BehaviorSubject<List<HeroItem>> _searchResultStream =
      BehaviorSubject<List<HeroItem>>(seedValue: []);
  Stream<List<HeroItem>> get searchResult => _searchResultStream.stream;

  // advantages
  final BehaviorSubject<List<HeroRecommendationItem>> _heroAdvantages =
      BehaviorSubject<List<HeroRecommendationItem>>(seedValue: []);
  Stream<List<HeroRecommendationItem>> get heroAdvantages =>
      _heroAdvantages.stream;

  // advantages
  final StreamController<FilterValue> _heroFilterController =
      StreamController<FilterValue>();
  Sink<FilterValue> get filterState => _heroFilterController.sink;

  final BehaviorSubject<List<bool>> _roleFilter =
      BehaviorSubject<List<bool>>(seedValue: [true, true, true, true, true]);
  Stream<List<bool>> get filter => _roleFilter.stream;

  Data data;

  StateBloc() {
    // load data
    data = Data();

    _heroStateController.stream.listen((item) {
      if (item.add) {
        _selectedHeroes.add(
          HeroSelectedItem(
            codename: item.codename,
            name: item.hero,
          ),
        );
      } else {
        _selectedHeroes.removeWhere((e) => e.codename == item.codename);
      }

      _heroes.add(_selectedHeroes);

      _advantages = calculateAdvantage(_selectedHeroes);
      filterItem();
    });

    _queryStateController.stream.listen((item) {
      keyword = item;
      _query.add(item);

      search();
    });

    _heroFilterController.stream.listen((item) {
      _filter[item.index] = item.value;

      _roleFilter.add(_filter);

      filterItem();
    });
  }

  void filterItem() {
    List<String> activeRoles = [];
    _filterString.asMap().forEach((i, e) {
      if (_filter[i]) activeRoles.add(e);
    });

    List<Hero> filtered = _advantages.where((item) {
      List<dynamic> roles = data.matchups[item.name]['roles'];
      return roles.where((role) => activeRoles.indexOf(role) > -1).length > 0;
    }).toList();

    List<HeroRecommendationItem> advantagesItem = filtered.map((e) {
      return HeroRecommendationItem(
        advantage: '${(e.percentage*100).toStringAsFixed(2)}%',
        codename: data.heroes[e.name]['codename'],
        name: data.heroes[e.name]['name'],
      );
    }).toList();
    _heroAdvantages.add(advantagesItem);
  }

  bool addHero({
    @required String codename,
    @required String name,
    @required bool add,
  }) {
    _query.add('');
    if (_selectedHeroes.length == 5) return false;

    _heroStateController.add(HeroAddition(
      codename: codename,
      hero: name,
      add: true,
    ));

    return true;
  }

  void search() {
    if (keyword == '') {
      _searchResult.clear();
      _searchResultStream.add(_searchResult);
      return;
    }

    bool exist(codename) {
      for (HeroSelectedItem hero in _selectedHeroes) {
        if (hero.codename == codename) return true;
      }
      return false;
    }

    _searchResult.clear();
    data.heroes.forEach((key, value) {
      String name = value['name'];
      String codename = value['codename'];

      if (exist(codename)) return;

      if (name.toLowerCase().indexOf(keyword.toLowerCase()) > -1) {
        _searchResult.add(HeroItem(
            codename: codename,
            hero: key,
            name: name,
            roles: data.matchups[key]['roles'].join(', ')));
      } else {
        for (String alias in data.heroes[key]['aliases']) {
          if (alias.indexOf(keyword.toLowerCase()) > -1) {
            _searchResult.add(HeroItem(
                codename: codename,
                hero: key,
                name: name,
                roles: data.matchups[key]['roles'].join(', ')));
            break;
          }
        }
      }
    });

    _searchResultStream.add(_searchResult);
  }

  void dispose() {
    _heroStateController.close();
    _queryStateController.close();
    _searchResultStream.close();
    _heroAdvantages.close();
    _heroFilterController.close();
    _roleFilter.close();
    _heroes.close();
  }
}
