import 'package:flutter/material.dart';

import 'header.dart';
import 'hero_list.dart';
import 'hero_selection.dart';
import 'hero_item.dart';
import 'hero_recommendation.dart';
import 'role_filter.dart';
import 'state/state_provider.dart';

void main() {
  runApp(new App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StateProvider(
      child: new MaterialApp(
        title: 'Dota Counter',
        theme: new ThemeData(
          primaryColor: const Color(0xFF2D3538),
          accentColor: const Color(0xFF2B3033),
        ),
        home: Content(),
      ),
    );
  }
}

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stateBloc = StateProvider.of(context);

    return new Scaffold(
      appBar: new Header(),
      body: new Container(
        color: const Color(0xFF2B3033),
        child: new Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: new Tooltip(
                          message: 'Dota 7.17',
                          child: new Icon(
                            Icons.info,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      StreamBuilder<List<HeroSelectedItem>>(
                        stream: stateBloc.selectedHeroes,
                        initialData: [],
                        builder: (context, snapshot) => Text(
                              snapshot.data.length == 0
                                  ? 'Add a hero first!'
                                  : 'Click hero icon to remove it',
                              style: new TextStyle(color: Colors.grey[500]),
                            ),
                      ),
                    ],
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: HeroSelection(),
                ),
                HeroRecommendation(),
                RoleFilter(),
              ],
            ),
            StreamBuilder<List<HeroItem>>(
              stream: stateBloc.searchResult,
              initialData: [],
              builder: (context, snapshot) => IgnorePointer(
                    ignoring: snapshot.data.length == 0,
                    child: HeroList(),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
