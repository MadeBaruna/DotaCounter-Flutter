import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

class Data {
  Map matchups;
  Map heroes;
  static final Data _data = new Data._internal();

  factory Data() {
    return _data;
  }

  Data._internal() {
    loadData();
  }

  Future loadData() async {
    print('load data');
    String _matchupsJson = await rootBundle.loadString('data/data.json');
    String _heroesJson = await rootBundle.loadString('data/heroes.json');

    matchups = await json.decode(_matchupsJson);
    heroes = await json.decode(_heroesJson);
  }
}
