import 'package:flutter/material.dart';
import 'hero_recommendation_item.dart';
import 'state/state.dart';
import 'state/state_provider.dart';

class HeroRecommendation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StateBloc state = StateProvider.of(context);

    return new Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Best Picks',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<HeroRecommendationItem>>(
                    stream: state.heroAdvantages,
                    initialData: [],
                    builder: (context, snapshot) => ListView.builder(
                          itemBuilder: (BuildContext context, int index) =>
                              snapshot.data[index],
                          itemCount: (snapshot.data.length / 2).ceil(),
                        ),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.grey[800],
            width: 1.0,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Worst Picks',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<HeroRecommendationItem>>(
                    stream: state.heroAdvantages,
                    initialData: [],
                    builder: (context, snapshot) {
                      return ListView.builder(
                          itemBuilder: (BuildContext context, int index) =>
                              snapshot.data[snapshot.data.length - index - 1],
                          itemCount: (snapshot.data.length / 2).floor(),
                        );
                    }
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
